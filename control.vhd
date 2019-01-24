--engineer: JESUS RODRIGUEZ OVEJERO

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
	Port ( rst : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 S_E: in STD_LOGIC;
			 S_S: in STD_LOGIC;
			 M_E: out STD_LOGIC;
			 M_S: out STD_LOGIC);
end control;

architecture a_control of control is

type clase_estado is (Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8);
signal estado_actual: clase_estado :=Q0;
signal estado_siguiente: clase_estado :=Q0;

begin

	process(clk,rst)
		begin
			if(rst ='1') then
				estado_actual <= Q0;
			elsif (clk'event and clk='1') then
					estado_actual <= estado_siguiente;
		end if;
	end process;
	-- estado_actual y entradas solo
	process(estado_actual,S_E,S_S)
		begin
			case estado_actual is 
			
			--esquema a seguir
				-- si la entrada es tanto y tanto
					--ponemos la salida
					--estado siguiente Qx
				when Q0=> 
					if (S_E = '1' and S_S = '0') then 
						M_E <= '1';
						M_S <= '0';
					estado_siguiente <= Q1;
					else 
						M_E <= '0';
						M_S <= '0';	
					estado_siguiente <= Q0;
					end if;
				when Q1=>
						M_E <= '1';
						M_S <= '0';
					estado_siguiente <= Q2;
				when Q2=>
					if (S_E = '0' and S_S = '0') then 
						M_E <= '0';
						M_S <= '0';
					estado_siguiente <= Q2;
					elsif(S_E ='1' and S_S = '1') then
						M_E <= '1';
						M_S <= '1';
					estado_siguiente <= Q7;
					elsif(S_E = '0' and S_S ='1') then 
						M_E <= '0';
						M_S <= '1';
					estado_siguiente <= Q8;
					else
						M_E <= '1';
						M_S <= '0';
					estado_siguiente <= Q3;
					end if;
				when Q3=>
						M_E <= '1';
						M_S <= '0';
					estado_siguiente <= Q4;
				when Q4=>
					if ((S_E = '0' and S_S = '0') or (S_E = '1' and S_S = '0') ) then 
						M_E <= '0';
						M_S <= '0';
					estado_siguiente <= Q4;
					elsif (S_E = '0' and S_S = '1') then
						M_E <= '0';
						M_S <= '1';
					estado_siguiente <= Q6;
					else 
						M_E <= '1';
						M_S <= '1';
					estado_siguiente <= Q5;
					end if;
				when Q5 =>
						M_E <= '1';
						M_S <= '1';
					estado_siguiente <= Q4;
				when Q6 =>	
						M_E <= '0';
						M_S <= '1';
					estado_siguiente <=Q2;
				when Q7 =>
						M_E <= '1';
						M_S <= '1';
					estado_siguiente <=Q2;
				when Q8 => 
						M_E <= '0';
						M_S <= '1';
					estado_siguiente <=Q0;
			end case;
		end process;
					
--	process(estado_actual,S_E,S_S)
--		begin 
--			--estado_actual y entradas solo, asignar aqui las salidas
--			if estado_actual=Q0 and S_E = '0' and S_S='0' then
--				M_E <= '0';
--				M_S <= '0';
--			else
--				M_E <= '1';
--				M_S <= '0';
--			end if;
--			
--			if estado_actual=Q1 then
--				M_E <= '1';
--				M_S <= '0';
--			end if;
--			
--			if estado_actual=Q2 and S_E='0' and S_S='0' then
--				M_E <= '0';
--				M_S <= '0';
--			elsif estado_actual=Q2 and S_E= '1' and S_S='0' then
--				M_E <= '1';
--				M_S <= '0';
--			elsif estado_actual=Q2 and S_E= '0' and S_S='1' then
--				M_E <= '0';
--				M_S <= '1';
--			else
--				M_E <= '1';
--				M_S <= '1';
--			end if;
--			
--			if estado_actual=Q3 then
--				M_E <= '1';
--				M_S <= '0';
--			end if;
--			
--			if estado_actual=Q4 and S_E='0' and S_S='0' then
--				M_E <= '0';
--				M_S <= '0';
--			elsif estado_actual=Q4 and S_E= '1' and S_S='0' then
--				M_E <= '0';
--				M_S <= '0';	
--			elsif estado_actual=Q4 and S_E= '1' and S_S='1' then
--				M_E <= '1';
--				M_S <= '1';
--			else 
--				M_E <= '0';
--				M_S <= '1';
--			end if;
--			
--			if estado_actual=Q5 then
--				M_E <= '1';
--				M_S <= '1';
--			end if;
--			
--			if estado_actual=Q6 then 
--				M_E <= '0';
--				M_S <= '1';
--			end if;
--			
--			if estado_actual=Q7 then 
--				M_E <= '1';
--				M_S <= '1';
--			end if;
--			
--			if estado_actual=Q8 then 
--				M_E <= '0';
--				M_S <= '1';
--			end if;
--	end process;

end a_control;

