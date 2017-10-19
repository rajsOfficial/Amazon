package com.main;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;

@PersistenceCapable
public class DeliveryPojo {

	@Persistent
	private long id;
	@Persistent
	private long phoneNumber;
	@Persistent
	private int quantity;
	@Persistent
	private String address;
	@Persistent 
	private String email;
	@Persistent
	private boolean delivered;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getPhoneNumber() {
		return phoneNumber;
	}
	public DeliveryPojo(long id, long phoneNumber, int quantity, String address, String email, boolean delivered) {
		super();
		this.id = id;
		this.phoneNumber = phoneNumber;
		this.quantity = quantity;
		this.address = address;
		this.email = email;
		this.delivered= delivered;

	}
	public void setPhoneNumber(long phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
