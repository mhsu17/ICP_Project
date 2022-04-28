/*********************************************************************
Using the Arduino libraries and Arduino IDE, the bluetooth transceiver
can be connected to the Adafruit Bluefruit App on iOS or Android to 
allow for wireless transfer of pressure data from the MPRLS pressure
sensor. 

This is a combination of the 
*********************************************************************/
#include <Arduino.h>
#include <SPI.h>
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "BluefruitConfig.h"

#include <Wire.h>
#include "Adafruit_MPRLS.h"

// You dont *need* a reset and EOC pin for most uses, so we set to -1 and don't connect
#define RESET_PIN  -1  // set to any GPIO pin # to hard-reset on begin()
#define EOC_PIN    -1  // set to any GPIO pin to read end-of-conversion by pin
Adafruit_MPRLS mpr = Adafruit_MPRLS(RESET_PIN, EOC_PIN);


#if SOFTWARE_SERIAL_AVAILABLE
  #include <SoftwareSerial.h>
#endif

/*=========================================================================
    APPLICATION SETTINGS

    FACTORYRESET_ENABLE       Perform a factory reset when running this sketch
   
                              Enabling this will put your Bluefruit LE module
                              in a 'known good' state and clear any config
                              data set in previous sketches or projects, so
                              running this at least once is a good idea.
   
                              When deploying your project, however, you will
                              want to disable factory reset by setting this
                              value to 0.  If you are making changes to your
                              Bluefruit LE device via AT commands, and those
                              changes aren't persisting across resets, this
                              is the reason why.  Factory reset will erase
                              the non-volatile memory where config data is
                              stored, setting it back to factory default
                              values.
       
                              Some sketches that require you to bond to a
                              central device (HID mouse, keyboard, etc.)
                              won't work at all with this feature enabled
                              since the factory reset will clear all of the
                              bonding data stored on the chip, meaning the
                              central device won't be able to reconnect.
    MINIMUM_FIRMWARE_VERSION  Minimum firmware version to have some new features
    MODE_LED_BEHAVIOUR        LED activity, valid options are
                              "DISABLE" or "MODE" or "BLEUART" or
                              "HWUART"  or "SPI"  or "MANUAL"
    -----------------------------------------------------------------------*/
    #define FACTORYRESET_ENABLE         1
    #define MINIMUM_FIRMWARE_VERSION    "0.6.6"
    #define MODE_LED_BEHAVIOUR          "MODE"
/*=========================================================================*/

// Create the bluefruit object
Adafruit_BluefruitLE_UART ble(Serial1, BLUEFRUIT_UART_MODE_PIN);

// A small helper
void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}


void setup(void) {
  if ( !ble.begin(VERBOSE_MODE) )
  {
    delay(500);
  }

  /* Perform a factory reset to make sure everything is in a known state */
  if ( FACTORYRESET_ENABLE )
  { 
    //ble.println("Performing a factory reset: ");
    if ( ! ble.factoryReset() ){
      delay(500);
    }
  }

   /* Disable command echo from Bluefruit */
  ble.echo(false);

  ble.verbose(false);  // debug info is a little annoying after this point!

  /* Wait for connection */
  while (! ble.isConnected()) {
      delay(500);
  }

  //Connect to MPRLS pressure sensor
  delay(2000);
  ble.println("MPRLS Simple Test");
  
  if (! mpr.begin()) {

    ble.println("Failed to communicate with MPRLS sensor, check wiring?");
    while (1) {
      delay(10);
    }
  }
  
  ble.println("Found MPRLS sensor");
}

void loop(void) {
  //Sending pressure sensor data to Adafruit app on phone:
  float pressure_hPa = mpr.readPressure();
  //Calibration is also needed so that the readings begin at 0. 14.68 is the calibration needed
  //for the trial run on 4/28
  ble.print("Pressure (PSI): "); ble.println((pressure_hPa / 68.947572932)-14.680000000);
  delay(1000);

}
