package model;

import java.io.Serializable;

public class Order implements Serializable {

    private int id;
    private int userId;
    private double totalAmount;
    private String orderDate;
    private String status;

    // =========================
    // DEFAULT CONSTRUCTOR
    // =========================
    public Order() {}

    // =========================
    // PARAMETERIZED CONSTRUCTOR
    // =========================
    public Order(int id, int userId, double totalAmount, String orderDate, String status) {
        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    // =========================
    // GETTERS & SETTERS
    // =========================
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // =========================
    // OPTIONAL: toString (DEBUGGING)
    // =========================
    @Override
    public String toString() {
        return "Order [id=" + id +
               ", userId=" + userId +
               ", totalAmount=" + totalAmount +
               ", orderDate=" + orderDate +
               ", status=" + status + "]";
    }
}