---
title: "CrabBot Ultra"
year: "2022-2023"
competition: "PowerPlay"
dimensions: "14.5\" x 15.5\""
weight: "~20 lbs"
motor: "4x GoBilda 312 rpm motors"
battery: "REV Lithium Battery"
draft: false
---

## About CrabBot Ultra

Our robot for the 2022-2023 FTC PowerPlay season was designed to score points by placing cones on junction tiles and parking on the charging station.

## Design Overview

Our bot consists of multiple sub-assemblies and sensors:

- **Drive-train (DT)**: The main chassis of the bot - four-motor, belt-driven mecanum drivetrain
- **Drive Belts**: Connects the wheels to the motors (2:3 gear ratio)
- **Odometry Pods**: Uses for tracking the position of the bot reliably
- **Lift System**: 5 stages of Misumi linear slides driven by continuous string
- **MGN12 Rail**: Separate lift stage that the claw is mounted to
- **Magnetic Gearbox**: Used for managing the MGN12 rail
- **Claw**: Used to grab game elements

## Drivetrain

We utilize a four-motor, belt-driven mecanum drivetrain, powered by 312 rpm GoBilda motors, with a 2:3 gear ratio on the belts. This configuration allows for increased speed and quick maneuvering, while maintaining silent and efficient operation. Coupled with our three dead wheel odometry system, our drivetrain provides accurate positioning during matches.

We use fully 3D printed side shields to ensure nothing gets caught in our wheels.

## Lift

We opted to use 5 stages of Misumi linear slides driven by a continuous string wound on a spool. We use a combination of two strings on each side of the lift; one to control extension, and the other to control retraction. This use of double stringing ensures accurate positioning of the lift in addition to keeping tension on the string at all times so it cannot tangle.

Reliable lift control is achieved through a PIDF loop that tracks the current and target position.

## Claw

Our claw was designed with simplicity and reliability in mind. We used a system of two counter-rotating servos and 3D printed claw pieces to effectively grab and place cones with ease.

## Magnetic Gearbox

We use a second-order magnetic gearbox to wind the string for our MGN rail when the lift retracts. The gear ratio is 2:1 (10 pole pairs input, 5 pole pairs output).
