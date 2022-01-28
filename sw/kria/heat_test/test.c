#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "mem-io.h"
#include "utils.h"
#include "proto2_hw.h"
#include "xspi_l.h"

float read_temp()
{
    FILE* fd_iio = fopen("/sys/bus/iio/devices/iio:device0/in_temp0_ps_temp_raw", "r");

    char iio_str[256];
    fscanf(fd_iio, "%s", iio_str);
    fclose(fd_iio);
    int iio_int = atoi(iio_str);
    //float temp = iio_int*503.975/4096.0 - 273.15;
    float temp = iio_int*503.975/65536.0 - 273.15;
    return(temp);
}

float read_vccint()
{
    FILE* fd_iio = fopen("/sys/bus/iio/devices/iio:device0/in_voltage2_vccint_raw", "r");

    char iio_str[256];
    fscanf(fd_iio, "%s", iio_str);
    fclose(fd_iio);
    int iio_int = atoi(iio_str);
    float vccint = iio_int*3.0/65536.0;
    return(vccint);
}

float read_vccaux()
{
    FILE* fd_iio = fopen("/sys/bus/iio/devices/iio:device0/in_voltage4_vccaux_raw", "r");
    char iio_str[256];
    fscanf(fd_iio, "%s", iio_str);
    fclose(fd_iio);
    int iio_int = atoi(iio_str);
    float vccaux = iio_int*3.0/65536.0;
    return(vccaux);
}



int main(int argc,char** argv)
{
    void* pcie_addr;

    uint32_t pcie_bar0_addr=BASE_ADDRESS;
    uint32_t pcie_bar0_size=PROTO_SIZE;

    pcie_addr=phy_addr_2_vir_addr(pcie_bar0_addr,pcie_bar0_size);
    if(pcie_addr==NULL) {
       fprintf(stderr,"can't mmap phy_addr 0x%08x with size 0x%08x to viraddr. you must be in root.\n",pcie_bar0_addr,pcie_bar0_size);
       exit(-1);
    }
    fprintf(stdout,"phy_addr 0x%08x with size 0x%08x to viraddr %p.\n",pcie_bar0_addr,pcie_bar0_size, pcie_addr);
    uint32_t chan_enable = 0x00000000;
    printf("chan_enable = 0x%08X\n", chan_enable);
    write_reg(pcie_addr,GPIO0_DATA, chan_enable); // enable the channels
    usleep(100);

    write_reg(pcie_addr,GPIO1_DATA, 0xffffffff); // clear the errors
    write_reg(pcie_addr,GPIO1_DATA, 0x00000000); // clear the errors
    uint32_t read_val;
    read_val = read_reg(pcie_addr,GPIO1_DATA2);
    printf("errors = 0x%08X\n", read_val);

    munmap(pcie_addr,pcie_bar0_size);

    float temp = read_temp();
    printf("temp = %f C;\n", temp);

    float vccint = read_vccint();
    printf("vccint = %f Volts;\n", vccint);

    float vccaux = read_vccaux();
    printf("vccaux = %f Volts;\n", vccaux);

    return 0;
}


