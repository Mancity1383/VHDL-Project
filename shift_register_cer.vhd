LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Shift_Register IS
    GENERIC (
        MBIT : INTEGER := 8
    );
    PORT (
        DATA : IN STD_LOGIC_VECTOR(MBIT - 1 DOWNTO 0);
        CLK : IN STD_LOGIC;
        EN : IN STD_LOGIC;
        GET_DATA : IN STD_LOGIC;
        DIR : IN STD_LOGIC;
        RSTN : IN STD_LOGIC;
        Output : OUT STD_LOGIC_VECTOR(MBIT - 1 DOWNTO 0)
    );
END Shift_Register;

ARCHITECTURE Structural OF Shift_Register IS
    SIGNAL Reg_Data : STD_LOGIC_VECTOR(MBIT - 1 DOWNTO 0);
BEGIN
    PROCESS (CLK, RSTN)
    BEGIN
        IF EN = '1' THEN
            IF RSTN = '0' THEN
                Reg_Data <= (OTHERS => '0');
            ELSIF GET_DATA = '1' THEN
                Reg_Data <= DATA;
            ELSIF rising_edge(CLK) THEN
                CASE DIR IS
                    WHEN '0' =>
                        Reg_Data <= Reg_Data(0) & Reg_Data(MBIT - 1 DOWNTO 1);
                    WHEN '1' =>
                        Reg_Data <= Reg_Data(MBIT - 2 DOWNTO 0) & Reg_Data(MBIT - 1);
                    WHEN OTHERS =>
                        NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    Output <= Reg_Data;
END Structural;