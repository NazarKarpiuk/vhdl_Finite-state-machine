-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- entity
entity vhdlFSM is
	port ( X,CLK : in std_logic; 
			     Y : out std_logic_vector(2 downto 0); 
	       Z1,Z2 : out std_logic); 
end vhdlFSM;
-- architecture
architecture my_FSM of vhdlFSM is
	type state_type is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7);
	signal PS, NS :state_type;
begin
	sync_proc: process(CLK,NS)
	begin 
		if (rising_edge(CLK)) then PS <= NS; 
		end if; 
	end process sync_proc;

	comb_proc: process(PS,X) 
	begin -- Z1,Z2: the Moore outputs;
		Z1 <= '0'; Z2 <= '0'; -- pre-assign the outputs 
		case PS is 
			when ST0 => -- items regarding state ST0 
				Z1 <= '0'; -- Moore outputs 
				Z2 <= '0';
				if (X = '1') then NS <= ST1;
				else NS <= ST0; 
				end if; 
			when ST1 => -- items regarding state ST1 
				Z1 <= '0'; -- Moore outputs
				Z2 <= '0';
				if (X = '1') then NS <= ST2;
				else NS <= ST1;
				end if; 
			when ST2 => -- items regarding state ST2 
				Z1 <= '0'; -- Moore outputs 
				Z2 <= '0';
				if (X = '1') then NS <= ST3; 
				else NS <= ST2; 
				end if; 
			when ST3 => -- items regarding state ST3 
				Z1 <= '1'; -- Moore outputs
				Z2 <= '0';
				if (X = '1') then NS <= ST4; 
				else NS <= ST3; 
				end if;
			when ST4 => -- items regarding state ST4 
				Z1 <= '0'; -- Moore outputs 
				Z2 <= '1';
				if (X = '0') then NS <= ST0;
				else NS <= ST5; 
				end if; 
			when ST5 => -- items regarding state ST5 
				Z1 <= '1'; -- Moore outputs
				Z2 <= '1';
				if (X = '1') then NS <= ST6;
				else NS <= ST5;
				end if;
			when ST6 => -- items regarding state ST6 
				Z1 <= '1'; -- Moore outputs 
				Z2 <= '1';
				if (X = '1') then NS <= ST7; 
				else NS <= ST6; 
				end if;
			when ST7 => -- items regarding state ST7 
				Z1 <= '1'; -- Moore outputs 
				Z2 <= '1';
				if (X = '1') then NS <= ST0; 
				else NS <= ST7; 
				end if; 
			when others => -- the catch all condition 
				Z1 <= '0'; Z2 <= '0'; NS <= ST0; 
		end case; 
	end process comb_proc;

	with PS select
		Y <= "000" when ST0,
			  "001" when ST1,
			  "010" when ST2,
			  "011" when ST3,
			  "100" when ST4,
			  "101" when ST5,
			  "110" when ST6,
			  "111" when ST7,
			  "000" when others;
end my_FSM;

