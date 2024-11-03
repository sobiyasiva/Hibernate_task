package com.example;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class CustomerServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
            System.out.println("SessionFactory initialized successfully.");
            // Sample data insertion removed
        } catch (Exception e) {
            System.err.println("SessionFactory initialization failed.");
            e.printStackTrace();
            throw new ServletException("Could not initialize SessionFactory", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers;
        try (Session session = sessionFactory.openSession()) {
            Query<Customer> query = session.createQuery("FROM Customer", Customer.class);
            customers = query.getResultList();
        } catch (Exception e) {
            System.err.println("Error retrieving customer list.");
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching the customer list.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        request.setAttribute("customerList", customers);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }


    public static void main(String[] args) {
        CustomerServlet customerServlet = new CustomerServlet();
        
        try {
            customerServlet.init();
            System.out.println("Servlet initialized.");
        } catch (ServletException e) {
            System.out.println(e);
        } 
    }
}
