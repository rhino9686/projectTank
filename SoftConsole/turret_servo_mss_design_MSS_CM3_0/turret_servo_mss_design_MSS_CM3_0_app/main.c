#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include "drivers/mss_spi/drivers/mss_spi/mss_spi.h"
#include "CMSIS/a2fxxxm3.h"

#define MASTER_TX_BUFFER 9
#define FREQ_ADDR 0x40050020
#define HITS_ADDR 0x40050024
uint8_t master_tx_buffer[MASTER_TX_BUFFER];
uint8_t master_rx_buffer[MASTER_TX_BUFFER]; 	//Initialize return array for Data buffer

void setupSPI(void);
void changeSpeed( volatile uint32_t*, int );

//int hits = 0;
__attribute__ ((interrupt)) void Fabric_IRQHandler( void )
{
	volatile uint32_t * hitsAddr = (volatile uint32_t *)(HITS_ADDR);
	uint32_t hits = *hitsAddr;
	hits++;
	*hitsAddr++ = hits;
    NVIC_ClearPendingIRQ( Fabric_IRQn );
    //NVIC_DisableIRQ(Fabric_IRQn); // Add interrupts to disable timer for certain period of time later
}

int main()
{
	volatile uint32_t * rlAddr = (volatile uint32_t *)(0x40050010); // Right/Left Servo
	volatile uint32_t * udAddr = (volatile uint32_t *)(0x40050014); // Up/Down Servo
	volatile uint32_t * freqAddr = (volatile uint32_t *)(FREQ_ADDR);
	volatile uint32_t * hitsAddr = (volatile uint32_t *)(HITS_ADDR);
	volatile uint32_t * motorAddr = (volatile uint32_t *) 0x40050004; // motor
	volatile uint32_t * pulsewidthAddr = (volatile uint32_t *) 0x40050008; // pulse width
	uint32_t joyVals = 0; // values from joysticks
	*hitsAddr = 0;

	// Enable FABINT
	NVIC_EnableIRQ(Fabric_IRQn);
	//NVIC_EnableIRQ(GPIO0_IRQn);

	uint32_t udPos = 900000; // Start at 90 deg. (middle position)
	uint32_t rlPos = 0;

	// Initialize servo positions
	*udAddr = udPos;
	*rlAddr = rlPos;

	//Setup SPI stuff
	setupSPI();

	//Full Polling: put in while 1 loop
	while(1) {
		
		master_tx_buffer[0] = 0x80;
		master_tx_buffer[1] = 0x42;
		master_tx_buffer[2] = 0x00;
		master_tx_buffer[3] = 0x00;
		master_tx_buffer[4] = 0x00;
		master_tx_buffer[5] = 0x00;
		master_tx_buffer[6] = 0x00;
		master_tx_buffer[7] = 0x00;
		master_tx_buffer[8] = 0x00;

		MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
		MSS_SPI_transfer_block
		(
			&g_mss_spi1,
			&master_tx_buffer,
			3, 	//3 bytes of command
			&master_rx_buffer,
			6 	//6 bytes of command
		);

		MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);

		int up = (master_rx_buffer[1] & (1 << 4)) != 0;
		int down = (master_rx_buffer[1] & (1 << 6)) != 0;
		int left = (master_rx_buffer[1] & (1 << 5)) != 0;
		int right = (master_rx_buffer[1] & (1 << 7)) != 0;
		int fire = (master_rx_buffer[1] & (1 << 1)) != 0;

		uint32_t LED = 0;

		//UP/DOWN LOGIC
		if (up == 0 && down) { //UP
			if (udPos == 1200000){ // At max, stay
				*udAddr = 1200000 / 1000;
			} 
			else {
				udPos += 10000;
				*udAddr = udPos / 1000; // Divide by 1000 for smoother turning
			}
			LED += 1;
		} 
		else if (down == 0 && up) { // down
			if (udPos == 600000){ // At min, stay
				*udAddr = 600000 / 1000;
			} 
			else {
				udPos -= 10000;
				*udAddr = udPos / 1000;
			}
			LED += 2;
		}
		// LEFT/RIGHT
		if (left == 0 && right) { //LEFT
			if (rlPos == 0){ // At min, stay
				*rlAddr = 0;
			} 
			else {
				rlPos -= 10000;
				*rlAddr = rlPos / 1000;
			}
			LED += 4;
		} 
		else if (right == 0 && left) { //RIGHT
			if (rlPos == 1800000){ // At max, stay
				*rlAddr = 1800000 / 1000;
			} 
			else {
				rlPos += 10000;
				*rlAddr = rlPos / 1000; // Divide by 1000 for smoother turning
			}
			LED += 8;
		}

		// Shoot
		if (fire == 0){
			*freqAddr = 56;
			LED += 16;
		} else {
			*freqAddr = 0; // Set back to 0 when done or not shooting
		}

		int8_t right_y = master_rx_buffer[3];	// down = -1, center = -2, up = 0
		int8_t left_y = master_rx_buffer[5];


		if((right_y == 0) && (left_y == 0)){ // robot go forward both sides
			joyVals = 0b1010;
		}
		else if((right_y == 0) && (left_y == -2)){ // robot go forward right, left stopped
			joyVals = 0b1011;
		}
		else if((right_y == 0) && (left_y == -1)){ // robot go forward right, left backwards
			joyVals = 0b1001;
		}
		else if((right_y == -1) && (left_y == 0)){ // robot go backward right, left forward
			joyVals = 0b0110;
		}
		else if((right_y == -1) && (left_y == -1)){ // robot go backward both sides
			joyVals = 0b0101;

		}
		else if((right_y == -1) && (left_y == -2)){ // robot go backward right, left stopped
			joyVals = 0b0111;
		}
		else if((right_y == -2) && (left_y == 0)){ // robot stopped right, forward left
			joyVals = 0b1110;
		}
		else if((right_y == -2) && (left_y == -1)){ // robot go stopped right, backward left
			joyVals = 0b1101;
		}
		else if((right_y == -2) && (left_y == -2)){ //robot fullstop
			joyVals = 0b1111;
		}
		*motorAddr = joyVals;

		changeSpeed(pulsewidthAddr, 45000); //change this number to fix pwm
		if(right_y || left_y) {}
		volatile int i = 0;
		while (i < 100000)
		{
			++i;
		}
	}

	return 0;
}

void setupSPI(void) {
	//Initial short polling for refresh and initiation
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0x42;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0xFF;
	master_tx_buffer[4] = 0xFF;

	MSS_SPI_init(&g_mss_spi1);
	MSS_SPI_configure_master_mode
	(
		&g_mss_spi1,
		MSS_SPI_SLAVE_0,
		MSS_SPI_MODE3,
		MSS_SPI_PCLK_DIV_256,
		MSS_SPI_BLOCK_TRANSFER_FRAME_SIZE
	);

	MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
	int i = 3;
	while(i) {
		MSS_SPI_transfer_block
		(
			&g_mss_spi1,
			&master_tx_buffer,
			5, 	//5 bytes of command
			&master_rx_buffer,
			5	//5 bytes of data
		);
		--i;
	}
	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);


	//Enter Config Mode
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0xc2;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0x80;
	master_tx_buffer[4] = 0x00;
	
	MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		5, 	//5 bytes of command
		&master_rx_buffer,
		5	//5 bytes of data
	);
	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);

	//Select Mode: Digital or Analog
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0x22;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0x80; //0x01 = analog, 0x00 = digital
	master_tx_buffer[4] = 0xc0; //0x03 = lock mode
	master_tx_buffer[5] = 0x00;
	master_tx_buffer[6] = 0x00;
	master_tx_buffer[7] = 0x00;
	master_tx_buffer[8] = 0x00;

	MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		9,	//9 bytes of command
		&master_rx_buffer,
		9 	//9 bytes of data
	);
	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);

	//Exit Config
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0xc2;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0x00;
	master_tx_buffer[4] = 0x5A;
	master_tx_buffer[5] = 0x5A;
	master_tx_buffer[6] = 0x5A;
	master_tx_buffer[7] = 0x5A;
	master_tx_buffer[8] = 0x5A;

	MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		9, 	//9 bytes of command
		&master_rx_buffer,
		9 	//9 bytes of data
	);
	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);

}
void changeSpeed( volatile uint32_t* speedPtr, int speed ){

	*speedPtr = speed;

	return;
}
