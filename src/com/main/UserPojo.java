package com.main;

import java.util.Set;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;

@PersistenceCapable
public class UserPojo {
	
	
	@Persistent
	private String firstname;
	@Persistent
	private String lastname;
	@Persistent
	private String email;
	@Persistent
	private long number;
	@Persistent
	private String password;
	@Persistent 
	private Set<Long> cartid;
	
	public  Set<Long> getCartid() {
		return cartid;
	}
	public void setCartid(Set<Long> cartid) {
		this.cartid = cartid;
	}
	public UserPojo() {
	}
	public UserPojo(String firstname, String lastname, String email, long number, String password) {
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.number = number;
		this.password = password;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getNumber() {
		return number;
	}
	public void setNumber(long number) {
		this.number = number;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
