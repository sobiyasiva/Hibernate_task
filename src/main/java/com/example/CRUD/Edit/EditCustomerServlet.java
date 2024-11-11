package com.example.CRUD.Edit;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.example.Customer;

@WebServlet("/editCustomerServlet")
public class EditCustomerServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long id = Long.parseLong(request.getParameter("id")); 
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));

        
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            Customer customerToUpdate = session.get(Customer.class, id); 

            if (customerToUpdate != null) {
                customerToUpdate.setName(name);
                customerToUpdate.setEmail(email);
                customerToUpdate.setPhoneNumber(phoneNumber);
                customerToUpdate.setAddress(address);
                customerToUpdate.setDateOfBirth(dateOfBirth);
                session.update(customerToUpdate);
                transaction.commit();

        request.getSession().setAttribute("successMessage", "Customer updated successfully.");
                System.out.println("Customer updated successfully.");
            } else {
                System.out.println("Error: Customer with ID " + id + " not found.");
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        response.sendRedirect("customerListServlet");
    }

}
