//
//  OBDCommandEnum.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 12/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
enum OBDCommandEnum: String {
    case NONE = "NONE"
    case RESET = "ATZ"
    case IDENTITY = "ATI"
    case READ_INPUT_VOLTAGE = "ATRV"
    case FUEL_LEVEL_INPUT = "0106"
    case FUEL_PRESSURE = "010A"
    case ENGINE_COOLANT_TEMPERATURE = "0105"
    case ENGINE_RPM = "010C"
    case VEHICLE_SPEED = "010D"
    case RUN_TIME_SINCE_ENGINE_START = "011F"
    case AMBIENT_AIR_TEMPERATURE = "0146"
    case MONITOR_ALL = "ATMA"
    case DISPLAY_ACTIVITY_MONITOR_COUNT = "ATAMC"
    case PROTOCOL_0 = "ATSP0"
    case PROVE_WORKING = "0100"
    case INTAKE_AIR_TEMPERATURE = "010F"
    case MAF_AIR_FLOW_RATE = "0110"
    case TIMING_ADVANCE = "010E"
    case INTAKE_MANIFOLD_PRESSURE = "010B"
    case BAROMETRIC_PRESSURE = "0133"
    case DISTANCE_TRAVELED_WITH_MALFUNCTION = "0121"
    case FUEL_RAIL_PRESSURE = "0122"
    case FUEL_RAIL_GAUGE_PRESSURE = "0123"
    case FUEL_TYPE = "0151"
    case FUEL_PRESSURE_CONTROL_SYSTEM = "016D"
    case INJECTION_PRESSURE_CONTROL_SYSTEM = "016E"
    case ENGINE_OIL_TEMPERATURE = "015C"
    case FUEL_INJECTION_TIMING = "015D"
    case ENGINE_FUEL_RATE = "015E"
    case HYBRID_BATTERY_PACK_REMAINING_LIFE = "015B"
    //new commands
    //DISPLAY_ACTIVITY_MONITOR_COUNT, INTAKE_AIR_TEMPERATURE, INTAKE_MANIFOLD_PRESSURE, TIMING_ADVANCE,
    //FUEL_PRESSURE_DIESEL, BAROMETRIC_PRESSURE, DISTANCE_TRAVELED_WITH_MALFUNCTION, FUEL_RAIL_PRESSURE,
    //FUEL_RAIL_GAUGE_PRESSURE, FUEL_TYPE, FUEL_PRESSURE_CONTROL_SYSTEM, INJECTION_PRESSURE_CONTROL_SYSTEM
    //ENGINE_OIL_TEMPERATURE, FUEL_INJECTION_TIMING, ENGINE_FUEL_RATE, HYBRID_BATTERY_PACK_REMAINING_LIFE
}
