#include <stdio.h>
#include <stdint.h>


int main()
{
	volatile uint32_t * switchAddr = (volatile uint32_t *)(0x40050000); // Switches
	volatile uint32_t * rlAddr = (volatile uint32_t *)(0x40050010); // Right/Left Servo
	volatile uint32_t * udAddr = (volatile uint32_t *)(0x40050014); // Up/Down Servo

	uint32_t switchVals = 0;
	uint32_t udPos = 900000; // Start at 90 deg. (middle position)
	uint32_t rlPos = 0;

	while( 1 )
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

		}


		// Currently no setup for up/down b/c of button limitations
		// However, MMIO is set up and works
		*udAddr = udPos / 1000;


	}

	return 0;
}
