LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Test_ShiftReg IS
END Test_ShiftReg;

ARCHITECTURE behavior OF Test_ShiftReg IS
    SIGNAL DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL EN : STD_LOGIC := '1';
    SIGNAL GET_DATA : STD_LOGIC := '1';
    SIGNAL DIR : STD_LOGIC := '0' ;
    SIGNAL RSTN : STD_LOGIC := '1';
    SIGNAL Output : STD_LOGIC_VECTOR(7 DOWNTO 0);
    constant CLK_PERIOD: time := 10 ps;
BEGIN
    uut : ENTITY work.Shift_Register
        PORT MAP(
            DATA => DATA,
            CLK => CLK,
            EN => EN,
            GET_DATA => GET_DATA,
            DIR => DIR,
            RSTN => RSTN,
            Output => Output
        );

    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    sim_process : process
    begin
        DATA <= "00000011";
        EN <= '1';
        GET_DATA <= '1';
        DIR <= '0';
        RSTN <= '1';
        wait for CLK_PERIOD;
        
        EN <= '1';
        GET_DATA <= '0';
        DIR <= '0';
        RSTN <= '1';
        wait for CLK_PERIOD;

        EN <= '1';
        GET_DATA <= '0';
        DIR <= '1';
        RSTN <= '1';
        wait for CLK_PERIOD;

        EN <= '0';
        wait for CLK_PERIOD;

        DATA <= "00000001";
        EN <= '1';
        GET_DATA <= '1';
        DIR <= '0';
        RSTN <= '1';
        wait for CLK_PERIOD;

        EN <= '1';
        GET_DATA <= '0';
        DIR <= '0';
        RSTN <= '1';
        wait for CLK_PERIOD;

        EN <= '0';
        wait for CLK_PERIOD;

        wait;
    end process;

end behavior;