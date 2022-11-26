
--sp,sn 
--counter needs to be defined somewhere
process state_transition_proc(sp,counter) --make sure whether counter is really needed.
begin

signal icode : std_logic_vector(3 downto 0):= "0000"; --icode is opcode
signal condcode : std_logic_vector(1 downto 0):= "00"; --icode is condition code
icode <= --T1 31 downto 28; 

case sp is
begin

when s0 =>
if icode = "1100" then
sn <= s2;

elsif icode = "1000" then
sn <= s8;

elsif icode = "1001" then
sn <= s8;

else 
sn <= s1;
end if;



when s1 =>
if icode = "0001" then
sn <= s5;

elsif icode = "0011" then
sn <= s11;

elsif icode = "0111" then
sn <= s16;

elsif icode = "0110" then
sn <= s19;

else
sn <= s2;
end if;


when s2 =>
if icode = "0100" then
sn <= s12;

elsif icode = "0101" then
sn <= s12;

elsif icode = "1100" then
sn <= s6;

else --main else

if condcode = "00" then --inner else
sn <= s3;

elsif (FC='1') then		--FC is the value of flag register
if(condcode = "10")
sn <= s3;					
else
sn <= s0;
end if;

elsif (FZ='1') then		--FZ is the value of zero register
if(condcode = "01")
sn <= s3;					
else
sn <= s0;
end if;
				
else
sn <= s0;
end if;--inner if ended
end if;--main if ended

when s3 =>
sn <= s4;

when s4 =>
sn <= s0;

when s5 =>
sn <= s3;

when s6 =>
sn <= s7;

when s7 =>
sn <= s0;

when s8 =>
if icode = "1000" then
sn <= s9;

else
sn <= s10;

when s9 =>
sn <= s0;

when s10 =>
sn <= s0;

when s11 =>
sn <= s0;

when s12 =>
if icode = "0100" then
sn <= s14;

else
sn <= s13;
end if;



when s13 =>
sn <= s0;

when s14 =>
sn <= s15;

when s15 =>
sn <= s0;

when s16 =>
sn <= s17;

when s17 =>
sn <= s18;

when s18 =>
if(counter < 8) then
sn <= s17;

else
sn <= s0;
end if;

when s19 =>
sn <= s20;

when s20 =>
sn <= s21;

when s21 =>
if(counter < 8) then
sn <= s20;
else 
sn <= s0;
end if;

when others=>
sn<= s0;
end case;

end process;
