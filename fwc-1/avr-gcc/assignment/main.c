#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>

bool in,clk,prev_clk,q = 0;

int main(){
	DDRB |= (1<<PB0);
	uint16_t in_counter = 0;
	while (1){
		in_counter+=500;
		if (in_counter>=1800){
			in = !in;
			in_counter=0;
		}
		clk = !clk;
		_delay_ms(500);

		if (prev_clk==0 && clk==1){
			bool d = in^q;
			q = d;
		}
		if (q){
			PORTB |= (1<<PB0);
		}
		else
			PORTB &= ~(1<<PB0);
	}
	
}
