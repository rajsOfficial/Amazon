package com.main;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;

@PersistenceCapable
public class DealerPojo {

	@Persistent
	private String dealername;
	@Persistent
	private long number;
	@Persistent
	private String email;
	@Persistent
	private String password;
	

	public DealerPojo(){
	}
	
	public DealerPojo(String dealername, long number, String email, String password) {
		this.dealername = dealername;
		this.number = number;
		this.email = email;
		this.password = password;
	}
	public String getDealername() {
		return dealername;
	}
	public void setDealername(String dealername) {
		this.dealername = dealername;
	}
	public long getNumber() {
		return number;
	}
	public void setNumber(long number) {
		this.number = number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
