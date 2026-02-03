/*
 * File: main.c
 * Author: Armstrong Subero
 * PIC: STM32F030F4P6 w/int OSC @ 8MHz, 3.3v
 * Program: 33_Piezo_Sound_Library.c
 * Compiler: ArmClang (v6.22, Keil uVision 5.40.0.3)
 * Program Version: 1.0
 *                
 * Program Description: This Program Allows the STM32F030F4P6 to 
 *                      control a Piezo Speaker 
 * 
 * Hardware Description: A Piezo speaker is connected to pin PA9
 *                       
 * Created January 5th, 2025, 6:23 PM
 * Last Updated: January 5th, 2025, 6:23 PM
 */
 

#include "stm32f030x6.h" // Include the device header for STM32F030F4P6
#include <math.h>
#include <stdlib.h>


//////////////////////////////////
// Setup 48-MHz Clock 
//////////////////////////////////

void SystemClock_Config(void)
{
    // Step 1: Enable HSI and wait for it to be ready
    RCC->CR |= RCC_CR_HSION; // Turn on HSI
    while (!(RCC->CR & RCC_CR_HSIRDY)); // Wait until HSI is ready
    
    // Step 2: Configure PLL
    RCC->CFGR &= ~RCC_CFGR_PLLSRC; // Select HSI as PLL source
    RCC->CFGR &= ~RCC_CFGR_PLLMUL; // Clear PLL multiplier
    RCC->CFGR |= RCC_CFGR_PLLMUL12; // Set PLL multiplier to 12
    RCC->CFGR2 &= ~RCC_CFGR2_PREDIV; // Clear PREDIV bits
    RCC->CFGR2 |= RCC_CFGR2_PREDIV_DIV1; // Set PREDIV to divide by 1
    
    RCC->CR |= RCC_CR_PLLON; // Turn on PLL
    while (!(RCC->CR & RCC_CR_PLLRDY)); // Wait until PLL is ready
    
    // Step 3: Configure Flash latency
    FLASH->ACR &= ~FLASH_ACR_LATENCY; // Clear latency bit
    FLASH->ACR |= FLASH_ACR_LATENCY;  // Set 1 wait state for 48 MHz operation
    
    // Step 4: Configure AHB and APB prescalers
    RCC->CFGR &= ~RCC_CFGR_HPRE; // AHB prescaler: SYSCLK not divided
    RCC->CFGR &= ~RCC_CFGR_PPRE; // APB prescaler: HCLK not divided
    
    // Step 5: Select PLL as system clock source
    RCC->CFGR &= ~RCC_CFGR_SW; // Clear system clock switch bits
    RCC->CFGR |= RCC_CFGR_SW_PLL; // Select PLL as system clock
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL); // Wait until PLL is used as system clock
    
    // Step 6: Update SystemCoreClock
    SystemCoreClock = 48000000; // Manually set SystemCoreClock to 48 MHz
}


////////////////////////////
// Delay Applications 
////////////////////////////

volatile uint32_t msTicks = 0; // Counter for milliseconds

void SysTick_Handler(void) {
    msTicks++; // Increment millisecond counter
}

void SysTick_Init(void) {
    // Reload value for 1ms tick
    SysTick->LOAD = (SystemCoreClock / 1000) - 1; // SystemCoreClock/1000 for 1ms
    SysTick->VAL = 0; // Clear current value
    SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | // Use processor clock
                    SysTick_CTRL_TICKINT_Msk |   // Enable SysTick interrupt
                    SysTick_CTRL_ENABLE_Msk;    // Enable SysTick
}

void delay_ms(uint32_t ms)
{
    uint32_t startTicks = msTicks; // Get the current millisecond tick count
    while ((msTicks - startTicks) < ms) {
        // Wait until the specified milliseconds have passed
    }
}

////////////////////////////////
// Piezo Control
///////////////////////////////

// Higher frequency note definitions (multiplied original frequencies by 4)
#define NOTE_C4  1047  // 262 * 4
#define NOTE_CS4 1108
#define NOTE_D4  1175
#define NOTE_DS4 1244
#define NOTE_E4  1319
#define NOTE_F4  1397
#define NOTE_FS4 1480
#define NOTE_G4  1568
#define NOTE_GS4 1661
#define NOTE_A4  1760
#define NOTE_AS4 1865
#define NOTE_B4  1976
#define NOTE_C5  2093
#define NOTE_CS5 2217
#define NOTE_D5  2349
#define NOTE_DS5 2489
#define NOTE_E5  2637
#define NOTE_F5  2794
#define NOTE_FS5 2960
#define NOTE_G5  3136
#define NOTE_GS5 3322
#define NOTE_A5  3520
#define NOTE_AS5 3729
#define NOTE_B5  3951
#define NOTE_C6  4186

// Initialize buzzer on PIN PA9
void Buzzer_Init(void) {
    // Enable TIM1 clock (TIM1 is on APB2)
    RCC->APB2ENR |= RCC_APB2ENR_TIM1EN;

    // Configure PA9 as Alternate Function (TIM1_CH2)
    RCC->AHBENR |= RCC_AHBENR_GPIOAEN;    // Enable GPIOA clock
    GPIOA->MODER &= ~(3U << (9 * 2));     // Clear PA9 mode
    GPIOA->MODER |= (2U << (9 * 2));      // Set PA9 to Alternate Function
    GPIOA->AFR[1] &= ~(0xF << ((9-8) * 4));   // Clear AF for PA9 (in AFR[1])
    GPIOA->AFR[1] |= (2U << ((9-8) * 4));     // AF2: TIM1_CH2

    // Configure Timer 1 for PWM mode
    TIM1->CR1 = 0;  // Reset CR1
    TIM1->CR2 = 0;  // Reset CR2
    
    // Configure timer for maximum frequency range
    TIM1->PSC = 0;   // No prescaling - run at full 48MHz
    TIM1->ARR = 999; // Initial value, will be updated by Buzzer_Set
    
    // Configure CH2 as PWM
    TIM1->CCMR1 &= ~TIM_CCMR1_OC2M;    // Clear output compare mode bits
    TIM1->CCMR1 |= (6U << TIM_CCMR1_OC2M_Pos); // PWM mode 1
    TIM1->CCMR1 |= TIM_CCMR1_OC2PE;    // Enable preload
    
    TIM1->CCER &= ~(TIM_CCER_CC2P);    // Active high polarity
    TIM1->CCER |= TIM_CCER_CC2E;       // Enable output
    
    // Enable main output (required for TIM1)
    TIM1->BDTR |= TIM_BDTR_MOE;
    
    // Initialize with 0 output
    TIM1->CCR2 = 0;
    
    // Enable the timer
    TIM1->CR1 |= TIM_CR1_CEN;
}

// Improved frequency generation
void Buzzer_Set(uint32_t frequency, uint8_t volume) {
    if (frequency == 0 || volume == 0) {
        TIM1->CCR2 = 0;  // Silent
        return;
    }
    
    // Simple frequency calculation for maximum frequency range
    TIM1->PSC = 0;   // No prescaling - run at full 48MHz
    TIM1->ARR = (48000000 / frequency) - 1;  // Direct frequency division
    
    // Set duty cycle
    TIM1->CCR2 = (TIM1->ARR * volume) / 200;  // Adjusted volume calculation
}

void Buzzer_Stop(void) {
    TIM1->CCR2 = 0;
}



////////////////////////////
// Test Appications 
///////////////////////////

// Test with continuous beeps
void Buzzer_Test_Continuous(void) {
    // Test standard piezo frequencies
    const uint32_t freq = 4000;  // 4kHz typical piezo resonant frequency
    
    // Continuous beep
    Buzzer_Set(freq, 50);
    delay_ms(1000);
    Buzzer_Stop();
    delay_ms(500);
    
    // Try a short series of beeps
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(freq, 50);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(50);
    }
    delay_ms(500);
    
    // Try a frequency sweep
    for(uint32_t f = 2000; f <= 4500; f += 100) {
        Buzzer_Set(f, 50);
        delay_ms(50);  // Faster sweep
    }
    Buzzer_Stop();
    delay_ms(500);
}

void Buzzer_Test_Frequencies(void) {
    // Test different frequencies in the typical piezo range
    uint32_t test_frequencies[] = {
        2000,   // 2kHz
        2500,   // 2.5kHz
        3000,   // 3kHz
        3500,   // 3.5kHz
        4000    // 4kHz
    };
    
    for(int i = 0; i < 5; i++) {
        // Set frequency at max volume
        Buzzer_Set(test_frequencies[i], 100);
        delay_ms(1000);
        Buzzer_Stop();
        delay_ms(500);
    }
}

void Buzzer_Simple_Beep(void) {
    const uint32_t freq = 9000;  // 4kHz
    Buzzer_Set(freq, 50);
    delay_ms(100);
    Buzzer_Stop();
}

void Buzzer_Sweep_Test(void) {
    // Test a wide range of frequencies
    for(uint32_t f = 1000; f <= 10000; f += 500) {
        Buzzer_Set(f, 50);
        delay_ms(200);
    }
    Buzzer_Stop();
    delay_ms(500);
}



////////////////////////////////////
// Industry Standard Applications
////////////////////////////////////

void Buzzer_Beep(uint32_t frequency, uint8_t volume, uint32_t duration_ms) {
    Buzzer_Set(frequency, volume);
    delay_ms(duration_ms);
    Buzzer_Stop();
}

// Standard feedback patterns - now using higher frequencies
void Buzzer_Success(void) {
    Buzzer_Beep(NOTE_C5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_E5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_G5, 50, 200);
}

void Buzzer_Failure(void) {
    Buzzer_Beep(NOTE_G5, 50, 200);
    delay_ms(50);
    Buzzer_Beep(NOTE_E5, 50, 400);
}

void Buzzer_Warning(void) {
    for(int i = 0; i < 3; i++) {
        Buzzer_Beep(NOTE_A5, 50, 100);
        delay_ms(100);
    }
}

void Buzzer_Alert(void) {
    for(int i = 0; i < 5; i++) {
        Buzzer_Beep(NOTE_A5, 70, 50);
        delay_ms(50);
    }
}

void Buzzer_KeyPress(void) {
    Buzzer_Beep(NOTE_C5, 30, 50);
}

void Buzzer_MenuSelect(void) {
    Buzzer_Beep(NOTE_E5, 40, 80);
}

void Buzzer_MenuBack(void) {
    Buzzer_Beep(NOTE_C5, 40, 80);
}

void Buzzer_PowerUp(void) {
    Buzzer_Beep(NOTE_C5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_E5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_G5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_C6, 50, 200);
}

void Buzzer_PowerDown(void) {
    Buzzer_Beep(NOTE_C6, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_G5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_E5, 50, 100);
    delay_ms(50);
    Buzzer_Beep(NOTE_C5, 50, 200);
}

void Buzzer_CriticalBattery(void) {
    for(int i = 0; i < 2; i++) {
        Buzzer_Beep(NOTE_G4, 70, 300);
        delay_ms(300);
    }
}

void Buzzer_Processing(void) {
    for(int i = 0; i < 3; i++) {
        Buzzer_Beep(NOTE_E5, 30, 50);
        delay_ms(100);
    }
}

void Buzzer_Error(void) {
    Buzzer_Beep(NOTE_B5, 70, 200);
    delay_ms(100);
    Buzzer_Beep(NOTE_B5, 70, 200);
    delay_ms(100);
    Buzzer_Beep(NOTE_B5, 70, 400);
}

// Improved siren effect with higher frequencies
void Buzzer_Siren(uint32_t duration_ms) {
    uint32_t steps = duration_ms / 5; // Faster update rate
    for(uint32_t i = 0; i < steps; i++) {
        // Sweep frequency between 2kHz and 4kHz
        uint32_t freq = 2000 + (2000 * sin(2 * 3.14159 * i / 50));
        Buzzer_Set(freq, 70);
        delay_ms(5);
    }
    Buzzer_Stop();
}

// Fast frequency sweep up
void Buzzer_SweepUp(uint32_t start_freq, uint32_t end_freq, uint32_t duration_ms) {
    uint32_t steps = duration_ms / 2;
    for(uint32_t i = 0; i < steps; i++) {
        uint32_t freq = start_freq + ((end_freq - start_freq) * i / steps);
        Buzzer_Set(freq, 70);
        delay_ms(2);
    }
    Buzzer_Stop();
}

// Fast frequency sweep down
void Buzzer_SweepDown(uint32_t start_freq, uint32_t end_freq, uint32_t duration_ms) {
    uint32_t steps = duration_ms / 2;
    for(uint32_t i = 0; i < steps; i++) {
        uint32_t freq = start_freq - ((start_freq - end_freq) * i / steps);
        Buzzer_Set(freq, 70);
        delay_ms(2);
    }
    Buzzer_Stop();
}

// Alarm effect (alternating between two frequencies)
void Buzzer_Alarm(void) {
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(3000, 70);
        delay_ms(100);
        Buzzer_Set(2000, 70);
        delay_ms(100);
    }
    Buzzer_Stop();
}


//////////////////////////////////
// Toy/Game Effects 
//////////////////////////////////

// Phone ring effect
void Buzzer_PhoneRing(void) {
    for(int i = 0; i < 2; i++) {
        // Two quick high beeps
        Buzzer_Set(2500, 70);
        delay_ms(80);
        Buzzer_Stop();
        delay_ms(80);
        Buzzer_Set(2500, 70);
        delay_ms(80);
        Buzzer_Stop();
        delay_ms(400);
    }
}

// Game start effect
void Buzzer_GameStart(void) {
    const uint32_t notes[] = {NOTE_C5, NOTE_E5, NOTE_G5, NOTE_C6};
    for(int i = 0; i < 4; i++) {
        Buzzer_Set(notes[i], 70);
        delay_ms(100);
    }
    delay_ms(200);
    Buzzer_Stop();
}

// Game over effect
void Buzzer_GameOver(void) {
    Buzzer_SweepDown(2000, 500, 500);
    delay_ms(100);
    Buzzer_SweepDown(1500, 350, 700);
}

// Level up effect
void Buzzer_LevelUp(void) {
    Buzzer_Set(1500, 70);
    delay_ms(80);
    Buzzer_Set(2000, 70);
    delay_ms(80);
    Buzzer_Set(2500, 70);
    delay_ms(80);
    Buzzer_Set(3000, 70);
    delay_ms(200);
    Buzzer_Stop();
}

// Coin collect effect
void Buzzer_CoinCollect(void) {
    Buzzer_Set(2000, 70);
    delay_ms(50);
    Buzzer_Set(3000, 70);
    delay_ms(100);
    Buzzer_Stop();
}

// Laser shoot effect
void Buzzer_LaserShoot(void) {
    Buzzer_SweepUp(1000, 4000, 100);
}

// Explosion effect
void Buzzer_Explosion(void) {
    // Quick sweep up
    Buzzer_SweepUp(1000, 3000, 50);
    // Followed by longer sweep down
    Buzzer_SweepDown(3000, 500, 400);
}

// Door bell effect (ding-dong)
void Buzzer_DoorBell(void) {
    Buzzer_Set(3000, 70);
    delay_ms(100);
    Buzzer_Stop();
    delay_ms(50);
    Buzzer_Set(2000, 70);
    delay_ms(200);
    Buzzer_Stop();
}

// Car lock effect
void Buzzer_CarLock(void) {
    // Lock beep
    Buzzer_Set(2000, 70);
    delay_ms(50);
    Buzzer_Stop();
    delay_ms(50);
    Buzzer_Set(2500, 70);
    delay_ms(50);
    Buzzer_Stop();
}

// Clock chime effect
void Buzzer_ClockChime(void) {
    const uint32_t notes[] = {NOTE_E5, NOTE_C5, NOTE_D5, NOTE_G4};
    for(int i = 0; i < 4; i++) {
        Buzzer_Set(notes[i], 70);
        delay_ms(200);
        Buzzer_Stop();
        delay_ms(100);
    }
}

void Buzzer_Demo(void) {
    // Basic patterns
    Buzzer_Success();
    delay_ms(1000);
    
    Buzzer_Failure();
    delay_ms(1000);
    
    Buzzer_Warning();
    delay_ms(1000);
    
    Buzzer_Alert();
    delay_ms(1000);
    
    // UI feedback
    Buzzer_KeyPress();
    delay_ms(500);
    
    Buzzer_MenuSelect();
    delay_ms(500);
    
    Buzzer_MenuBack();
    delay_ms(1000);
    
    // System status
    Buzzer_PowerUp();
    delay_ms(1000);
    
    Buzzer_PowerDown();
    delay_ms(1000);
    
    Buzzer_CriticalBattery();
    delay_ms(1000);
    
    Buzzer_Processing();
    delay_ms(1000);
    
    Buzzer_Error();
    delay_ms(1000);
    
    // Effects
    Buzzer_Siren(2000);
    delay_ms(1000);
    
    Buzzer_Alarm();
    delay_ms(1000);
    
    Buzzer_PhoneRing();
    delay_ms(1000);
    
    Buzzer_GameStart();
    delay_ms(1000);
    
    Buzzer_GameOver();
    delay_ms(1000);
    
    Buzzer_LevelUp();
    delay_ms(1000);
    
    Buzzer_CoinCollect();
    delay_ms(1000);
    
    Buzzer_LaserShoot();
    delay_ms(1000);
    
    Buzzer_Explosion();
    delay_ms(1000);
    
    Buzzer_DoorBell();
    delay_ms(1000);
    
    Buzzer_CarLock();
    delay_ms(1000);
    
    Buzzer_ClockChime();
    delay_ms(1000);
}





/////////////////////////////
// Military Applications 
/////////////////////////////

// Countdown beep effect with accelerating pace
void Buzzer_Countdown(uint32_t duration_ms) 
{
    uint32_t beep_freq = 2200;  // Beep frequency
    uint32_t initial_delay = 1000;  // Start with 1 second between beeps
    uint32_t elapsed = 0;
    
    while(elapsed < duration_ms) {
        // Make beep
        Buzzer_Set(beep_freq, 70);
        delay_ms(50);  // Short beep duration
        Buzzer_Stop();
        
        // Calculate next delay (exponentially decreasing)
        initial_delay = (initial_delay * 8) / 10;  // Reduce delay by 20% each time
        if(initial_delay < 50) initial_delay = 50;  // Don't go faster than 50ms
        
        delay_ms(initial_delay);
        elapsed += (50 + initial_delay);
    }
    
    // Final long beep
    Buzzer_Set(3000, 100);  // Higher frequency, full volume
    delay_ms(500);
    Buzzer_Stop();
}

// More intense countdown with pitch change
void Buzzer_CountdownIntense(uint32_t duration_ms) 
{
    uint32_t start_freq = 2200;
    uint32_t initial_delay = 1000;
    uint32_t elapsed = 0;
    
    while(elapsed < duration_ms) {
        // Make beep with increasing frequency
        Buzzer_Set(start_freq, 70);
        delay_ms(50);
        Buzzer_Stop();
        
        // Increase pitch slightly each time
        start_freq += 50;
        
        // Calculate next delay (exponentially decreasing)
        initial_delay = (initial_delay * 7) / 10;  // Reduce delay by 30% each time
        if(initial_delay < 30) initial_delay = 30;  // Don't go faster than 30ms
        
        delay_ms(initial_delay);
        elapsed += (50 + initial_delay);
    }
    
    // Final explosion effect
    Buzzer_Explosion();
}


// Radar/Sonar Ping
void Buzzer_Ping(void) {
    Buzzer_SweepDown(4000, 1000, 100);
    delay_ms(50);
    Buzzer_SweepUp(1000, 4000, 50);
}




//////////////////////////////////
// Consumer Goods 
//////////////////////////////////

// Scanner/Processing effect (like a barcode reader)
void Buzzer_Scanner(void) {
    Buzzer_Set(2500, 70);
    delay_ms(80);
    Buzzer_Stop();
    delay_ms(20);
    Buzzer_Set(3000, 50);
    delay_ms(40);
    Buzzer_Stop();
}


// WiFi/Bluetooth Connected
void Buzzer_Connected(void) {
    Buzzer_Set(2000, 50);
    delay_ms(50);
    Buzzer_Stop();
    delay_ms(50);
    Buzzer_Set(2500, 50);
    delay_ms(100);
    Buzzer_Stop();
}

// WiFi/Bluetooth Disconnected
void Buzzer_Disconnected(void) {
    Buzzer_Set(2500, 50);
    delay_ms(50);
    Buzzer_Stop();
    delay_ms(50);
    Buzzer_Set(2000, 50);
    delay_ms(100);
    Buzzer_Stop();
}

// Charging Started
void Buzzer_ChargingStart(void) {
    Buzzer_SweepUp(1500, 3000, 200);
}

// Charging Complete
void Buzzer_ChargingComplete(void) {
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(3000, 60);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(100);
    }
}

// Reminder (gentler than alarm)
void Buzzer_Reminder(void) {
    for(int i = 0; i < 2; i++) {
        Buzzer_Set(2000, 40);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(300);
    }
}

// Timer Complete
void Buzzer_TimerComplete(void) {
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(4000, 70);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(100);
        Buzzer_Set(3000, 70);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(300);
    }
}


////////////////////////////////////
// SciFi Kit
////////////////////////////////////

// Mechanical transformation sound
void Buzzer_Transform(void) {
    // Initial mechanical whine
    Buzzer_SweepUp(1000, 4000, 200);
    
    // Transformation sequence
    for(int i = 0; i < 4; i++) {
        // Servo movements
        Buzzer_Set(3000, 70);
        delay_ms(50);
        Buzzer_Set(2000, 70);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(20);
    }
    
    // Final lock sound
    Buzzer_Set(4000, 70);
    delay_ms(100);
    Buzzer_Set(3000, 70);
    delay_ms(200);
    Buzzer_Stop();
}

// Energy shield/force field
void Buzzer_Shield(void) {
    // Shield powering up
    Buzzer_SweepUp(2000, 4000, 100);
    
    // Shield humming
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(3500 + (i * 100), 40);
        delay_ms(100);
        Buzzer_Set(3500 - (i * 100), 40);
        delay_ms(100);
    }
    
    // Shield stabilizing
    Buzzer_SweepDown(4000, 3500, 100);
    Buzzer_Stop();
}

// Teleporter/transporter effect
void Buzzer_Teleport(void) {
    // Initial charge
    Buzzer_SweepUp(1000, 4000, 200);
    
    // Teleport energy build
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(3000 + (rand() % 1000), 50);
        delay_ms(20);
        Buzzer_Set(3500 + (rand() % 1000), 50);
        delay_ms(20);
    }
    
    // Transport effect
    Buzzer_SweepUp(3000, 5000, 100);
    Buzzer_Stop();
    delay_ms(50);
    Buzzer_SweepDown(5000, 1000, 200);
}

// Space ship fly-by
void Buzzer_SpaceShip(void) {
    // Approach
    Buzzer_SweepUp(100, 3000, 500);
    
    // Pass by
    Buzzer_Set(3000, 70);
    delay_ms(100);
    
    // Move away
    Buzzer_SweepDown(3000, 100, 700);
}

// Energy blast charging and release
void Buzzer_EnergyBlast(void) {
    // Charge up
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(2000 + (i * 400), 50 + (i * 10));
        delay_ms(100);
    }
    
    // Release blast
    Buzzer_Set(4000, 70);
    delay_ms(200);
    Buzzer_SweepDown(4000, 1000, 300);
}

// Robot happy sound
void Buzzer_RobotHappy(void) {
    // Happy chirp sequence
    for(int i = 0; i < 3; i++) {
        Buzzer_SweepUp(2000, 4000, 50);
        delay_ms(50);
    }
    Buzzer_Set(4000, 50);
    delay_ms(100);
    Buzzer_Stop();
}

// Robot sad sound
void Buzzer_RobotSad(void) {
    // Sad descending sequence
    Buzzer_SweepDown(2000, 1000, 300);
    delay_ms(50);
    Buzzer_SweepDown(1500, 800, 400);
    Buzzer_Stop();
}


////////////////////////
// Startup
////////////////////////

// Classic Nokia-style startup
void Buzzer_StartupClassic(void) {
    // Notes for the melody
    const uint32_t notes[] = {NOTE_E5, NOTE_D5, NOTE_FS4, NOTE_GS4, NOTE_CS5, NOTE_B4, NOTE_D4, NOTE_E4, NOTE_B4, NOTE_A4, NOTE_CS4, NOTE_E4, NOTE_A4};
    const uint32_t durations[] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 200};
    
    for(int i = 0; i < 13; i++) {
        Buzzer_Set(notes[i], 60);
        delay_ms(durations[i]);
        Buzzer_Stop();
        delay_ms(20);  // Small gap between notes
    }
}

// Modern tech startup (Apple-inspired)
void Buzzer_StartupModern(void) {
    const uint32_t notes[] = {NOTE_C5, NOTE_E5, NOTE_G5, NOTE_C6};
    const uint32_t durations[] = {200, 200, 200, 400};
    const uint8_t volumes[] = {40, 50, 60, 70};
    
    for(int i = 0; i < 4; i++) {
        Buzzer_Set(notes[i], volumes[i]);
        delay_ms(durations[i]);
        if(i < 3) Buzzer_Stop();
        delay_ms(50);
    }
    // Fade out last note
    for(int vol = 70; vol >= 0; vol -= 2) {
        Buzzer_Set(NOTE_C6, vol);
        delay_ms(20);
    }
    Buzzer_Stop();
}


// Game console style startup
void Buzzer_StartupGameConsole(void) {
    // Initial sweep
    Buzzer_SweepUp(1000, 3000, 200);
    delay_ms(50);
    
    // Triumphant notes
    const uint32_t notes[] = {NOTE_G4, NOTE_C5, NOTE_E5, NOTE_G5, NOTE_C6};
    const uint32_t durations[] = {100, 100, 100, 100, 300};
    
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(notes[i], 60);
        delay_ms(durations[i]);
        Buzzer_Stop();
        delay_ms(30);
    }
}

// Professional/Corporate startup
void Buzzer_StartupCorporate(void) {
    // Simple, professional ascending tone
    const uint32_t notes[] = {NOTE_C5, NOTE_E5, NOTE_G5};
    const uint32_t durations[] = {150, 150, 300};
    const uint8_t volumes[] = {40, 50, 60};
    
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(notes[i], volumes[i]);
        delay_ms(durations[i]);
        Buzzer_Stop();
        delay_ms(50);
    }
}

// Sci-fi computer startup
void Buzzer_StartupSciFi(void) {
    // Initial power-up whine
    Buzzer_SweepUp(500, 3000, 300);
    delay_ms(100);
    
    // System check beeps
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(2000 + (i * 500), 40);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(50);
    }
    
    // Final boot confirmation
    Buzzer_Set(4000, 50);
    delay_ms(100);
    Buzzer_Set(3000, 40);
    delay_ms(200);
    Buzzer_Stop();
}

// Retro computer startup
void Buzzer_StartupRetro(void) {
    // Initial click
    Buzzer_Set(2000, 50);
    delay_ms(50);
    Buzzer_Stop();
    delay_ms(100);
    
    // Power on tone
    Buzzer_Set(1000, 40);
    delay_ms(300);
    
    // Ascending beeps
    for(int i = 0; i < 4; i++) {
        Buzzer_Set(1500 + (i * 500), 50);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(50);
    }
    
    // Ready beep
    Buzzer_Set(3000, 60);
    delay_ms(200);
    Buzzer_Stop();
}

/////////////////////////////
// Mario Melody 
/////////////////////////////

// Note definitions specific for Mario theme
#define MARIO_E5  2637
#define MARIO_C5  2093
#define MARIO_G4  1568
#define MARIO_E4  1318
#define MARIO_A4  1760
#define MARIO_B4  1975
#define MARIO_AS4 1865
#define MARIO_D5  2349
#define MARIO_F4  1397
#define MARIO_F5  2794
#define MARIO_D4  1175
#define MARIO_G5  3136    // Added G5
#define MARIO_B5  3951    // Added B5
#define MARIO_A5  3520    // Added A5
#define MARIO_E6  5274    // Added E6

// Tempo control
#define TEMPO_MARIO 100  // Adjustable tempo (lower = faster)

// Simple delay wrapper for tempo control
void Note_Delay(uint32_t tempo) {
    delay_ms(tempo);
}

// Play a note for a specific duration
void Play_Note(uint32_t note, uint32_t duration) {
    Buzzer_Set(note, 70);  // 70% volume
    Note_Delay(duration);
    Buzzer_Stop();
    Note_Delay(20);  // Small gap between notes
}

// Play main theme of Super Mario Bros
void Buzzer_MarioTheme(void) {
    // First measure
    Play_Note(MARIO_E5, TEMPO_MARIO);
    Play_Note(MARIO_E5, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_E5, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_C5, TEMPO_MARIO);
    Play_Note(MARIO_E5, TEMPO_MARIO*2);
    
    // Second measure
    Play_Note(MARIO_G4, TEMPO_MARIO*2);
    Note_Delay(TEMPO_MARIO*2);
    
    // Third measure
    Play_Note(MARIO_G4, TEMPO_MARIO*2);
    Note_Delay(TEMPO_MARIO*2);
    
    // Next sequence
    Play_Note(MARIO_C5, TEMPO_MARIO*2);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_G4, TEMPO_MARIO*2);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_E4, TEMPO_MARIO*2);
    
    // Continue sequence
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_A4, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_B4, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_AS4, TEMPO_MARIO);
    Play_Note(MARIO_A4, TEMPO_MARIO);
    
    // Next part
    Play_Note(MARIO_G4, TEMPO_MARIO);
    Play_Note(MARIO_E5, TEMPO_MARIO);
    Play_Note(MARIO_G5, TEMPO_MARIO);
    Play_Note(MARIO_A5, TEMPO_MARIO);
    
    // Following sequence
    Play_Note(MARIO_F5, TEMPO_MARIO);
    Play_Note(MARIO_G5, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_E5, TEMPO_MARIO);
    Note_Delay(TEMPO_MARIO);
    Play_Note(MARIO_C5, TEMPO_MARIO);
    Play_Note(MARIO_D5, TEMPO_MARIO);
    Play_Note(MARIO_B4, TEMPO_MARIO);
    
    // Final part of main theme
    Note_Delay(TEMPO_MARIO*2);
}

// Play Mario coin sound effect
void Buzzer_MarioCoin(void) {
    Play_Note(MARIO_B5, 50);
    Play_Note(MARIO_E6, 100);
}

// Play Mario jump sound effect
void Buzzer_MarioJump(void) {
    Buzzer_SweepUp(500, 1500, 100);
}

// Play Mario death sound
void Buzzer_MarioDeath(void) {
    Play_Note(MARIO_B4, 100);
    Note_Delay(30);
    Play_Note(MARIO_F4, 100);
    Note_Delay(30);
    Buzzer_SweepDown(MARIO_F4, MARIO_D4, 300);
}

// Demo function to play Mario sounds
void Buzzer_MarioDemo(void) {
    // Play main theme
    Buzzer_MarioTheme();
    delay_ms(1000);
    
    // Play sound effects
    Buzzer_MarioCoin();
    delay_ms(500);
    
    Buzzer_MarioJump();
    delay_ms(500);
    
    Buzzer_MarioDeath();
    delay_ms(1000);
}


///////////////////////////
// 8-bit Chiptunes Style 
//////////////////////////

// Basic NES/Game Boy style sound frequencies
#define CHIP_C3  130
#define CHIP_CS3 139
#define CHIP_D3  147
#define CHIP_DS3 156
#define CHIP_E3  165
#define CHIP_F3  175
#define CHIP_FS3 185
#define CHIP_G3  196
#define CHIP_GS3 208
#define CHIP_A3  220
#define CHIP_AS3 233
#define CHIP_B3  247
#define CHIP_C4  262
#define CHIP_CS4 277
#define CHIP_D4  294
#define CHIP_DS4 311
#define CHIP_E4  330
#define CHIP_F4  349
#define CHIP_FS4 370
#define CHIP_G4  392
#define CHIP_GS4 415
#define CHIP_A4  440
#define CHIP_AS4 466
#define CHIP_B4  494

// Tempo definitions
#define TEMPO_FAST  50
#define TEMPO_MED   100
#define TEMPO_SLOW  150

// Duty cycle for square wave simulation
#define DUTY_12  12   // 12.5% duty cycle
#define DUTY_25  25   // 25% duty cycle
#define DUTY_50  50   // 50% duty cycle
#define DUTY_75  75   // 75% duty cycle

// Play a note with specific duty cycle
void Chip_Note(uint32_t freq, uint8_t duty, uint32_t duration) {
    Buzzer_Set(freq, duty);
    delay_ms(duration);
    Buzzer_Stop();
    delay_ms(5);  // Small gap between notes
}

// Classic 8-bit jump effect
void Chip_Jump(void) {
    for(uint32_t f = 500; f < 2000; f += 200) {
        Chip_Note(f, DUTY_12, 20);
    }
}

// 8-bit coin collect
void Chip_Coin(void) {
    Chip_Note(CHIP_B4, DUTY_12, 30);
    Chip_Note(CHIP_E4, DUTY_12, 60);
}

// 8-bit power up
void Chip_PowerUp(void) {
    for(uint32_t i = 0; i < 8; i++) {
        Chip_Note(CHIP_C4 + (i * 50), DUTY_25, 40);
    }
}

// 8-bit power down
void Chip_PowerDown(void) {
    for(uint32_t i = 8; i > 0; i--) {
        Chip_Note(CHIP_C4 + (i * 50), DUTY_25, 40);
    }
}

// 8-bit explosion
void Chip_Explosion(void) {
    for(int i = 0; i < 10; i++) {
        uint32_t freq = 100 + (rand() % 2000);
        Chip_Note(freq, DUTY_12, 20);
    }
}

// Simple 8-bit melody
void Chip_SimpleMusic(void) {
    const uint32_t notes[] = {
        CHIP_C4, CHIP_E4, CHIP_G4, CHIP_C4,
        CHIP_G4, CHIP_E4, CHIP_C4, 0
    };
    
    const uint32_t durations[] = {
        TEMPO_MED, TEMPO_MED, TEMPO_MED, TEMPO_MED,
        TEMPO_MED, TEMPO_MED, TEMPO_SLOW, TEMPO_FAST
    };
    
    for(int i = 0; i < 8; i++) {
        if(notes[i] == 0) {
            delay_ms(durations[i]);
        } else {
            Chip_Note(notes[i], DUTY_25, durations[i]);
        }
    }
}

// Arpeggio effect (common in chiptunes)
void Chip_Arpeggio(void) {
    const uint32_t chord[] = {CHIP_C4, CHIP_E4, CHIP_G4};
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 3; j++) {
            Chip_Note(chord[j], DUTY_12, 40);
        }
    }
}

// Retro "level complete" fanfare
void Chip_LevelComplete(void) {
    Chip_Note(CHIP_C4, DUTY_25, TEMPO_FAST);
    Chip_Note(CHIP_E4, DUTY_25, TEMPO_FAST);
    Chip_Note(CHIP_G4, DUTY_25, TEMPO_FAST);
    Chip_Note(CHIP_C4, DUTY_25, TEMPO_MED);
    delay_ms(TEMPO_FAST);
    Chip_Note(CHIP_G4, DUTY_25, TEMPO_MED);
    Chip_Note(CHIP_C4, DUTY_25, TEMPO_SLOW);
}

// "Game Over" sound
void Chip_GameOver(void) {
    Chip_Note(CHIP_C4, DUTY_50, TEMPO_MED);
    Chip_Note(CHIP_G3, DUTY_50, TEMPO_MED);
    Chip_Note(CHIP_E3, DUTY_50, TEMPO_MED);
    Chip_Note(CHIP_C3, DUTY_50, TEMPO_SLOW);
}

// Laser shoot effect
void Chip_Laser(void) {
    for(uint32_t f = 2000; f > 200; f -= 200) {
        Chip_Note(f, DUTY_12, 10);
    }
}

// 8-bit item pickup
void Chip_ItemPickup(void) {
    Chip_Note(CHIP_E4, DUTY_25, 50);
    Chip_Note(CHIP_G4, DUTY_25, 50);
    Chip_Note(CHIP_E4, DUTY_25, 50);
}

// Demo of all chiptune effects
void Chip_Demo(void) {
    Chip_Jump();
    delay_ms(500);
    
    Chip_Coin();
    delay_ms(500);
    
    Chip_PowerUp();
    delay_ms(500);
    
    Chip_PowerDown();
    delay_ms(500);
    
    Chip_Explosion();
    delay_ms(500);
    
    Chip_SimpleMusic();
    delay_ms(500);
    
    Chip_Arpeggio();
    delay_ms(500);
    
    Chip_LevelComplete();
    delay_ms(500);
    
    Chip_GameOver();
    delay_ms(500);
    
    Chip_Laser();
    delay_ms(500);
    
    Chip_ItemPickup();
    delay_ms(500);
}


///////////////////////////////
// Animal Sounds 
///////////////////////////////

// Enhanced rooster crow with more detail
void Animal_Bird1(void) {
    // Initial throat clear
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(500 + (rand() % 200), 30);
        delay_ms(20);
    }
    
    // Main crow with harmonics
    for(uint32_t f = 800; f < 2200; f += 50) {
        // Primary frequency
        Buzzer_Set(f, 70);
        delay_ms(10);
        // Add harmonic
        Buzzer_Set(f * 1.5, 40);
        delay_ms(10);
    }
    
    // Hold the peak
    for(int i = 0; i < 10; i++) {
        Buzzer_Set(2200, 70);
        delay_ms(20);
        Buzzer_Set(2100, 65);
        delay_ms(20);
    }
    
    // Decay
    for(uint32_t f = 2200; f > 800; f -= 100) {
        Buzzer_Set(f, 50);
        delay_ms(10);
    }
    Buzzer_Stop();
}


// More realistic cat meow with harmonics
void Animal_Bird2(void) {
    // Initial mouth opening sound
    for(uint32_t f = 400; f < 600; f += 20) {
        Buzzer_Set(f, 20);
        delay_ms(5);
    }
    
    // Main meow with harmonics
    for(uint32_t f = 600; f < 1800; f += 30) {
        // Primary frequency
        Buzzer_Set(f, 40);
        delay_ms(3);
        // Add harmonic
        Buzzer_Set(f * 1.5, 20);
        delay_ms(3);
    }
    
    // Tail end of meow
    for(uint32_t f = 1800; f > 400; f -= 50) {
        Buzzer_Set(f, 30);
        delay_ms(2);
    }
    Buzzer_Stop();
}

// More realistic dog bark with attack and decay
void Animal_DogBark(void) {
    // Sharp attack with harmonics
    for(uint32_t f = 800; f < 1200; f += 100) {
        Buzzer_Set(f, 70);
        delay_ms(5);
        Buzzer_Set(f * 1.5, 40);
        delay_ms(5);
    }
    
    // Hold
    Buzzer_Set(1200, 70);
    delay_ms(50);
    
    // Natural decay
    for(uint32_t f = 1200; f > 300; f -= 100) {
        Buzzer_Set(f, 60 - (60-f/100));
        delay_ms(5);
    }
    Buzzer_Stop();
}

// More natural bird chirp with variations
void Animal_BirdChirp(void) {
    for(int i = 0; i < 3; i++) {
        // Randomize base frequency for variation
        uint32_t base_freq = 3000 + (rand() % 1000);
        
        // Rising chirp
        for(uint32_t f = base_freq; f < base_freq + 500; f += 100) {
            Buzzer_Set(f, 30);
            delay_ms(5);
        }
        
        // Falling chirp
        for(uint32_t f = base_freq + 500; f > base_freq; f -= 150) {
            Buzzer_Set(f, 20);
            delay_ms(3);
        }
        
        Buzzer_Stop();
        delay_ms(50 + (rand() % 100)); // Random delay between chirps
    }
}



// Enhanced howl with tremolo effect
void Cyber_Animal1(void) {
    // Initial ramp up
    for(uint32_t f = 300; f < 800; f += 20) {
        Buzzer_Set(f, 40);
        delay_ms(10);
    }
    
    // Main howl with tremolo
    for(int i = 0; i < 40; i++) {
        // Oscillate between two close frequencies for tremolo
        Buzzer_Set(800 + (i * 10), 60 + (i % 20));
        delay_ms(20);
        Buzzer_Set(780 + (i * 10), 55 + (i % 20));
        delay_ms(20);
    }
    
    // Natural decay
    for(uint32_t f = 1200; f > 300; f -= 10) {
        Buzzer_Set(f, 40);
        delay_ms(10);
    }
    Buzzer_Stop();
}


// Enhanced trumpet
void Cyber_Animal2(void) {
    // Initial air blow
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(200 + (rand() % 100), 30);
        delay_ms(20);
    }
    
    // Rising trumpet with harmonics
    for(uint32_t f = 200; f < 600; f += 20) {
        // Main frequency
        Buzzer_Set(f, 70);
        delay_ms(10);
        // Harmonics
        Buzzer_Set(f * 1.5, 40);
        delay_ms(5);
        Buzzer_Set(f * 2, 20);
        delay_ms(5);
    }
    
    // Sustained trumpet with variation
    for(int i = 0; i < 10; i++) {
        Buzzer_Set(600 + (rand() % 100), 70);
        delay_ms(30);
    }
    
    // Decay
    for(uint32_t f = 600; f > 200; f -= 20) {
        Buzzer_Set(f, 60);
        delay_ms(10);
    }
    Buzzer_Stop();
}


void Bird_SequenceDemo(void)
{
	
	 Animal_Bird1();
	delay_ms(2000);
			
			 Animal_Bird2();
			 delay_ms(3000);
			 Animal_Bird2();
			 delay_ms(2000);
			
			 for (int i = 0; i<= 5; i++)
			 {
			  Animal_BirdChirp();
			  delay_ms(2000);
			 }
	
}


/////////////////////////////////
// Robot Dog Sounds 
//////////////////////////////////

// Single bark with more realistic harmonics
void Dog_SingleBark(uint8_t intensity) {
    // Initial throat sound
    for(uint32_t f = 200; f < 400; f += 50) {
        Buzzer_Set(f, 20);
        delay_ms(5);
    }
    
    // Sharp attack with harmonics
    for(uint32_t f = 800; f < 1200; f += 100) {
        Buzzer_Set(f, intensity);
        delay_ms(5);
        Buzzer_Set(f * 1.5, intensity/2);  // First harmonic
        delay_ms(5);
    }
    
    // Brief hold at peak
    Buzzer_Set(1200, intensity);
    delay_ms(50);
    
    // Natural decay with harmonics
    for(uint32_t f = 1200; f > 300; f -= 100) {
        Buzzer_Set(f, intensity - (f/40));
        delay_ms(5);
        Buzzer_Set(f * 1.5, (intensity/2) - (f/40));  // Decaying harmonic
        delay_ms(5);
    }
    Buzzer_Stop();
}

// Quick warning bark sequence
void Dog_WarningBarks(void) {
    for(int i = 0; i < 3; i++) {
        Dog_SingleBark(70);  // Sharp, loud bark
        delay_ms(200);  // Quick succession
    }
}

// Excited bark sequence
void Dog_ExcitedBarks(void) {
    for(int i = 0; i < 5; i++) {
        // Randomize intensity for natural variation
        uint8_t intensity = 50 + (rand() % 30);
        Dog_SingleBark(intensity);
        delay_ms(150 + (rand() % 100));  // Random timing between barks
    }
}

// Low growl
void Dog_Growl(void) {
    // Base growl frequency
    for(int i = 0; i < 20; i++) {
        uint32_t base_freq = 150 + (rand() % 50);  // Slight frequency variation
        Buzzer_Set(base_freq, 40);
        delay_ms(20);
        Buzzer_Set(base_freq * 1.5, 20);  // Harmonic
        delay_ms(20);
    }
    Buzzer_Stop();
}

// Playful bark sequence
void Dog_PlayfulBarks(void) {
    for(int i = 0; i < 4; i++) {
        // Higher pitched, shorter barks
        for(uint32_t f = 1000; f < 1500; f += 200) {
            Buzzer_Set(f, 40);
            delay_ms(3);
        }
        Buzzer_Stop();
        delay_ms(200 + (rand() % 200));  // Variable delays
    }
}

// Alert sequence: growl + warning barks
void Dog_AlertSequence(void) {
    Dog_Growl();
    delay_ms(200);
    Dog_WarningBarks();
    delay_ms(300);
    Dog_Growl();
    delay_ms(200);
    Dog_SingleBark(80);  // Final loud bark
}

// Excited greeting sequence
void Dog_ExcitedGreeting(void) {
    // Initial excited barks
    Dog_ExcitedBarks();
    delay_ms(200);
    
    // Mix in some playful barks
    Dog_PlayfulBarks();
    delay_ms(200);
    
    // More excited barks
    Dog_ExcitedBarks();
}

// Guard dog sequence
void Dog_GuardSequence(void) {
    // Initial warning growl
    Dog_Growl();
    delay_ms(500);
    
    // Series of warning barks
    for(int i = 0; i < 2; i++) {
        Dog_WarningBarks();
        delay_ms(300);
    }
    
    // Final growl and bark
    Dog_Growl();
    delay_ms(200);
    Dog_SingleBark(90);  // Very loud final bark
}

// Lonely/Distant howl-bark sequence
void Dog_LonelySequence(void) {
    // Start with a whimper
    for(uint32_t f = 500; f < 800; f += 50) {
        Buzzer_Set(f, 30);
        delay_ms(10);
    }
    Buzzer_Stop();
    delay_ms(500);
    
    // Couple of soft barks
    for(int i = 0; i < 2; i++) {
        Dog_SingleBark(40);
        delay_ms(400);
    }
    
    // End with a longer, softer bark
    Dog_SingleBark(30);
}

// Demo of all dog sounds
void RobotDog_SequenceDemo(void) {
    // Single bark
    //printf("Single bark...\n");
    Dog_SingleBark(70);
    delay_ms(1000);
    
    // Warning barks
    //printf("Warning barks...\n");
    Dog_WarningBarks();
    delay_ms(1000);
    
    // Excited barks
   // printf("Excited barks...\n");
    Dog_ExcitedBarks();
    delay_ms(1000);
    
    // Growl
    //printf("Growling...\n");
    Dog_Growl();
    delay_ms(1000);
    
    // Playful barks
    //printf("Playful barks...\n");
    Dog_PlayfulBarks();
    delay_ms(1000);
    
    // Alert sequence
    //printf("Alert sequence...\n");
    Dog_AlertSequence();
    delay_ms(1000);
    
    // Excited greeting
    //printf("Excited greeting...\n");
    Dog_ExcitedGreeting();
    delay_ms(1000);
    
    // Guard sequence
    //printf("Guard sequence...\n");
    Dog_GuardSequence();
    delay_ms(1000);
    
    // Lonely sequence
    //printf("Lonely sequence...\n");
    Dog_LonelySequence();
    delay_ms(1000);
}


// Basic mechanical movement sounds
void Robot_Servo(uint32_t start_freq, uint32_t end_freq, uint32_t duration) {
    for(uint32_t f = start_freq; f <= end_freq; f += 50) {
        Buzzer_Set(f, 40);
        delay_ms(duration/10);
    }
    Buzzer_Stop();
}

// Electronic whine
void Robot_Electronic(void) {
    for(uint32_t f = 2000; f < 4000; f += 100) {
        Buzzer_Set(f, 30);
        delay_ms(5);
    }
    Buzzer_Stop();
}

// Robot Startup Sequence
void Robot_PowerUpSequence(void) {
    // Initial power-on whine
    for(uint32_t f = 500; f < 2000; f += 50) {
        Buzzer_Set(f, 40);
        delay_ms(5);
    }
    Buzzer_Stop();
    delay_ms(200);
    
    // System checks
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(2000, 30);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(100);
    }
    
    // Servo movements
    Robot_Servo(1000, 2000, 200);
    delay_ms(100);
    Robot_Servo(2000, 1000, 200);
    
    // Ready beep
    Buzzer_Set(3000, 50);
    delay_ms(200);
    Buzzer_Stop();
}

// Robot Shutdown Sequence
void Robot_ShutdownSequence(void) {
    // Alert beeps
    for(int i = 0; i < 2; i++) {
        Buzzer_Set(2000, 40);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(100);
    }
    
    // Power down whine
    for(uint32_t f = 2000; f > 200; f -= 50) {
        Buzzer_Set(f, 40 - (f/100));
        delay_ms(10);
    }
    Buzzer_Stop();
}

// Robot Walking Sequence
void Robot_WalkSequence(void) {
    for(int i = 0; i < 4; i++) {
        // Leg servo up
        Robot_Servo(1000, 1500, 100);
        delay_ms(50);
        
        // Step down
        Robot_Servo(1500, 800, 100);
        delay_ms(100);
        
        // Weight shift
        Buzzer_Set(500, 60);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(200);
    }
}

// Robot Battle Mode Activation
void Robot_BattleModeSequence(void) {
    // Alert siren
    for(int i = 0; i < 2; i++) {
        for(uint32_t f = 1000; f < 2000; f += 100) {
            Buzzer_Set(f, 60);
            delay_ms(10);
        }
        for(uint32_t f = 2000; f > 1000; f -= 100) {
            Buzzer_Set(f, 60);
            delay_ms(10);
        }
    }
    
    // Systems charging up
    for(uint32_t f = 500; f < 4000; f += 100) {
        Buzzer_Set(f, 50);
        delay_ms(5);
    }
    
    // Weapon systems online
    Buzzer_Set(4000, 70);
    delay_ms(200);
    Buzzer_Stop();
    delay_ms(100);
    
    // Ready beep
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(3000, 60);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(50);
    }
}

// Robot Error Sequence
void Robot_ErrorSequence(void) {
    // Error alert
    for(int i = 0; i < 3; i++) {
        Buzzer_Set(2000, 70);
        delay_ms(100);
        Buzzer_Stop();
        delay_ms(100);
    }
    
    // System failure tones
    for(uint32_t f = 2000; f > 200; f -= 200) {
        Buzzer_Set(f, 60);
        delay_ms(50);
        Buzzer_Stop();
        delay_ms(50);
    }
    
    // Final error buzz
    for(int i = 0; i < 5; i++) {
        Buzzer_Set(200, 70);
        delay_ms(200);
        Buzzer_Stop();
        delay_ms(100);
    }
}

// Robot Scanning Sequence
void Robot_ScanSequence(void) {
    // Scanning sweep
    for(int i = 0; i < 3; i++) {
        // Sweep up
        for(uint32_t f = 1000; f < 3000; f += 100) {
            Buzzer_Set(f, 40);
            delay_ms(10);
        }
        delay_ms(100);
        
        // Sweep down
        for(uint32_t f = 3000; f > 1000; f -= 100) {
            Buzzer_Set(f, 40);
            delay_ms(10);
        }
        delay_ms(200);
    }
    
    // Target found beep
    Buzzer_Set(2000, 60);
    delay_ms(200);
    Buzzer_Stop();
}

// Robot Computing Sequence
void Robot_ComputingSequence(void) {
    // Processing sounds
    for(int i = 0; i < 10; i++) {
        uint32_t freq = 2000 + (rand() % 2000);
        Buzzer_Set(freq, 30);
        delay_ms(50 + (rand() % 50));
        Buzzer_Stop();
        delay_ms(20);
    }
    
    // Completion beep
    Buzzer_Set(3000, 50);
    delay_ms(200);
    Buzzer_Stop();
}

// Robot Full Demo Sequence
void Robot_SequenceDemo(void) {
    // Power up
    Robot_PowerUpSequence();
    delay_ms(1000);
    
    // Walk
    Robot_WalkSequence();
    delay_ms(1000);
    
    // Scan
    Robot_ScanSequence();
    delay_ms(1000);
    
    // Computing
    Robot_ComputingSequence();
    delay_ms(1000);
    
    // Battle mode
    Robot_BattleModeSequence();
    delay_ms(1000);
    
    // Error
    Robot_ErrorSequence();
    delay_ms(1000);
    
    // Shutdown
    Robot_ShutdownSequence();
    delay_ms(1000);
}

////////////////////////////////
//  Main Function 
///////////////////////////////

int main(void)
{
    SystemClock_Config(); // Configure system clock to 48 MHz
    SysTick_Init();       // Initialize SysTick for 1ms ticks
	
	  Buzzer_Init();
	
	  Buzzer_Demo();

	
    while (1)
    {
  
		}
}
