#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include "drivers/mss_spi/drivers/mss_spi/mss_spi.h"

#define MASTER_TX_BUFFER 9

uint8_t master_tx_buffer[MASTER_TX_BUFFER] =
	{
		0x80, 0x42, 0x00, 0xFF, 0xFF	//Command Data buffer
	};

uint8_t master_rx_buffer[MASTER_TX_BUFFER*2]; 	//Initialize return array for Data buffer

void setupSPI(void);

int main()
{
	//volatile uint32_t * switchAddr = (volatile uint32_t *)(0x40050000); // Switches
	volatile uint32_t * rlAddr = (volatile uint32_t *)(0x40050010); // Right/Left Servo
	volatile uint32_t * udAddr = (volatile uint32_t *)(0x40050014); // Up/Down Servo

	//uint32_t switchVals = 0;
	uint32_t udPos = 900000; // Start at 90 deg. (middle position)
	uint32_t rlPos = 0;

	// Initialize servo positions
	*udAddr = udPos;
	*rlAddr = rlPos;

	// SPI stuff
	setupSPI();
	/*uint8_t master_tx_buffer[MASTER_TX_BUFFER] =
	{
		0x80, 0x42, 0x00, 0xFF, 0xFF	//Command Data buffer
	}; */

	//uint8_t master_rx_buffer[MASTER_TX_BUFFER*2]; 	//Initialize return array for Data buffer
	//uint8_t master_rx_buffer2[MASTER_TX_BUFFER]; 	//Initialize return array for Data buffer


	//
	//i = 1;
	//Polling: put in while 1 loop

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

		// up/down
		if (up == 0 && down) { // up
			if (udPos == 1200000){ // At max, stay
				*udAddr = 1200000 / 1000;
			} else {
				udPos += 100;
				*udAddr = udPos / 1000; // Divide by 1000 for smoother turning
			}
			LED += 1;
		} else if (down == 0 && up) { // down
			if (udPos == 600000){ // At min, stay
				*udAddr = 600000 / 1000;
			} else {
				udPos -= 100;
				*udAddr = udPos / 1000;
			}
			LED += 2;
		}

		// left/right
		if (left == 0 && right) { // left
			if (rlPos == 0){ // At min, stay
				*rlAddr = 0;
			} else {
				rlPos -= 100;
				*rlAddr = rlPos / 1000;
			}
			LED += 4;
		} else if (right == 0 && left) { // right
			if (rlPos == 1800000){ // At max, stay
				*rlAddr = 1800000 / 1000;
			} else {
				rlPos += 100;
				*rlAddr = rlPos / 1000; // Divide by 1000 for smoother turning
			}
			LED += 8;
		}
		if (fire == 0)
			LED += 16;


		//uint32_t * LED_address = (uint32_t*) 0x40050000;
		//*LED_address = LED;

		int8_t right_y = master_rx_buffer[3];	// down = -1, center = 1, up = 0
		int8_t left_y = master_rx_buffer[5];

		if(right_y || left_y)
		{

		}
	}

	/*while( 1 )
	{
		switchVals = *switchAddr; // Get switch values

		if (switchVals == 2) { // CW (right)
			if (rlPos == 1800000){ // At max, stay
				*rlAddr = 1800000 / 1000;
			} else {
				rlPos += 1;
				*rlAddr = rlPos / 1000; // Divide by 1000 for smoother turning
			}
		} else if (switchVals == 1) { // CCW (left)
			if (rlPos == 0){ // At min, stay
				*rlAddr = 0;
			} else {
				rlPos -= 1;
				*rlAddr = rlPos / 1000;
			}

		} */


		// Currently no setup for up/down b/c of button limitations
		// However, MMIO is set up and works
		//*udAddr = udPos / 1000;


	//}

	return 0;
}

void setupSPI(void) {


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
	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		5, 	//5 bytes of command
		&master_rx_buffer,
		5	//5 bytes of command
	);
	//Extra polling for refresh and initiation
	int i = 2;
	while(i) {
		master_tx_buffer[0] = 0x80;
		master_tx_buffer[1] = 0x42;
		master_tx_buffer[2] = 0x00;
		master_tx_buffer[3] = 0xFF;
		master_tx_buffer[4] = 0xFF;
		 MSS_SPI_transfer_block
		(
			&g_mss_spi1,
			&master_tx_buffer,
			5, 	//5 bytes of command
			&master_rx_buffer,
			5	//5 bytes of command
		);
		--i;
	}

	//Enter Config Mode
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0xc2;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0x80;
	master_tx_buffer[4] = 0x00;

	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		5, 	//5 bytes of command
		&master_rx_buffer,
		5	//5 bytes of command
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
		9 	//9 bytes of command
	);

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


	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		9, 	//9 bytes of command
		&master_rx_buffer,
		9 	//9 bytes of command
	);

	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
}

// COMMENTED OUT CODE JUST IN CASE

/* MOVED TO SETUPSPI
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
	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		5, 	//5 bytes of command
		&master_rx_buffer,
		5	//5 bytes of command
	);
	//Extra polling for refresh and initiation
	int i = 2;
	while(i) {
		master_tx_buffer[0] = 0x80;
		master_tx_buffer[1] = 0x42;
		master_tx_buffer[2] = 0x00;
		master_tx_buffer[3] = 0xFF;
		master_tx_buffer[4] = 0xFF;
		 MSS_SPI_transfer_block
		(
			&g_mss_spi1,
			&master_tx_buffer,
			5, 	//5 bytes of command
			&master_rx_buffer,
			5	//5 bytes of command
		);
		--i;
	}

	//Enter Config Mode
	master_tx_buffer[0] = 0x80;
	master_tx_buffer[1] = 0xc2;
	master_tx_buffer[2] = 0x00;
	master_tx_buffer[3] = 0x80;
	master_tx_buffer[4] = 0x00;

	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		5, 	//5 bytes of command
		&master_rx_buffer,
		5	//5 bytes of command
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
		9 	//9 bytes of command
	);

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


	MSS_SPI_transfer_block
	(
		&g_mss_spi1,
		&master_tx_buffer,
		9, 	//9 bytes of command
		&master_rx_buffer,
		9 	//9 bytes of command
	);

	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0); */

