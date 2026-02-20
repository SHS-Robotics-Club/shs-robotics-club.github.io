---
title: "PowerPlay 2022-23"
date: 2022-09-01
year: "2022-23"
competition: "PowerPlay"
robot_name: "Spontaneous Combustion"
code_link: "https://github.com/SHS-Robotics-Club/powerplay-2022-23"
start_date: 2022-09-01
end_date: 2023-04-15
draft: false

sponsors:
  - name: "Seminole High School"
    tier: "school"
  - name: "Advisory Committee"
    tier: "gold"
  - name: "Raytheon"
    tier: "platinum"
  - name: "Lockheed Martin"
    tier: "gold"
  - name: "Pinellas County STEM"
    tier: "gold"
  - name: "TBTA"
    tier: "support"

events:
  - name: "Season Scrimmage"
    date: 2022-10-15
    result: "Participated"
  - name: "League Meet 1"
    date: 2022-11-20
    result: "Learning experience"
  - name: "League Meet 3"
    date: 2023-01-15
    result: "Improved performance"
  - name: "Gulf Coast League Tournament"
    date: 2023-02-15
    result: "Finalist Alliance"

awards:
  - name: "Finalist Alliance"
    event: "Gulf Coast League Tournament"

outreach:
  - "Anona Elementary Science Night"
  - "Largo Playcon"
  - "STEM Explorer Fest"
  - "Mentored Team 22532 The Phantom Menaces"
  - "Mentored Team 3736 Serious Business"

team_members:
  - { name: "Quinn", role: "Team Captain", years: 4 }
  - { name: "Cody", role: "Coach", years: 3 }
  - { name: "Thomas", role: "Programmer & Build", years: 1, from_team: 3736 }
  - { name: "John Carly", role: "Build & Outreach", years: 1, from_team: 3736 }
---

## Season Summary

Starting off this year, we transitioned from our old build system (Tetrix) to GoBilda. We did this for a number of reasons but it really boils down to better tolerances, and much better ease of use for general mechanisms.

## Robot Design

Our bot consists of multiple sub-assemblies and sensors:

- **Drive-train (DT)**: The main chassis of the bot
- **Drive Belts**: Connects the wheels to the motors
- **Odometry Pods**: Used for tracking the position of the bot reliably
- **Lift System**: 5 stages of Misumi linear slides driven by continuous string
- **MGN12 Rail**: Separate lift stage that the claw is mounted to
- **Magnetic Gearbox**: Used for managing the MGN12 rail
- **Claw**: Used to grab game elements

## Drivetrain

We utilize a four-motor, belt-driven mecanum drivetrain, powered by 312 rpm GoBilda motors, with a 2:3 gear ratio on the belts. This configuration allows for increased speed and quick maneuvering, while maintaining silent and efficient operation. Coupled with our three dead wheel odometry system, our drivetrain provides accurate positioning during matches.

## Lift

We opted to use 5 stages of Misumi linear slides driven by a continuous string wound on a spool. We use a combination of two strings on each side of the lift; one to control extension, and the other to control retraction. This use of double stringing ensures accurate positioning of the lift in addition to keeping tension on the string at all times so it cannot tangle.

## Competition Results

- **Scrimmage**: Exceeded expectations, basic claw and autonomous
- **LM1**: Learned about time management, designed slide inserts
- **LM3**: Added retract strings, lift sorted out
- **Gulf Coast League Tournament**: Selected as finalist alliance, gearbox issues in finals

## Outreach

We participated in various events including Anona Elementary's Science Night, Largo Playcon, and STEM Explorer Fest. We also mentored Team 22532 The Phantom Menaces and our sister team 3736 Serious Business.
