# MOVEMENTS
Multi-camera system design for birds monitoring

### Instlation and use
### Hardware triger

VHDL files implemented in Vivado 2019.2.<br />

**To compile:**
- create Vivado vhdl or mixed project for existed Digilent Basys3 with xc7a35tcpg236-3 (Artix-7)
- import XDS constraints https://github.com/igorfed/MOVEMENTS/tree/master/HW_Camera_Trigger/cons to projects constraints folder
- import vhdl files https://github.com/igorfed/MOVEMENTS/tree/master/HW_Camera_Trigger in to projects source <br />

**To Run HW trigger:**
- copy bitstream file https://github.com/igorfed/MOVEMENTS/tree/master/HW_Camera_Trigger/bit to USB flash memory (FAT 32)
- follow the instruction in USB Host Programming https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual?_ga=2.116810245.2022396390.1593004547-31038319.1593004547 <br /> 
JP1 set to USB mode. <br /> 
Place bitstream file in the root directory of flash memory.<br />
The FPGA will automatically be configured with the bitstream file when power on of the device. LD19 must be green when FPGA has been succesfully configured.

**On/Off HW triggering:**

FPGA generates two meanders with selectable frequencys (250 ms, 200 ms and 50 ms)  
- **4 fps  SW[3 downto 0] = "00100" (4 in HEX format)**
<img src0 = "Images/HWTrigger/4fps.png" width = 600>
- **5 fps  SW[3 downto 0] = "00100" (4 in HEX format)**
<img src1 = "Images/HWTrigger/5fps.png" width = 600>
- **20 fps  SW[3 downto 0] = "00100" (4 in HEX format)**
<img src2 = "Images/HWTrigger/20fps.png" width = 600>

To stop meander any orther combinations in SW[3 downto 0] must be selected.


