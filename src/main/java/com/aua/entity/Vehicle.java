package com.aua.entity;

public class Vehicle {
    long id;
    int number;
    VehicleType vehicleType;
    int cycleLength;
    int cycleDuration;
    int quantity;
    int interval;

    public Vehicle(int number, VehicleType vehicleType,
                   int cycleLength, int cycleDuration,
                   int quantity, int interval) {
        this.number = number;
        this.vehicleType = vehicleType;
        this.cycleLength = cycleLength;
        this.cycleDuration = cycleDuration;
        this.quantity = quantity;
        this.interval = interval;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public VehicleType getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(VehicleType vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getCycleLength() {
        return cycleLength;
    }

    public void setCycleLength(int cycleLength) {
        this.cycleLength = cycleLength;
    }

    public int getCycleDuration() {
        return cycleDuration;
    }

    public void setCycleDuration(int cycleDuration) {
        this.cycleDuration = cycleDuration;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getInterval() {
        return interval;
    }

    public void setInterval(int interval) {
        this.interval = interval;
    }
}
