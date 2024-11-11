package com.example.CRUD.Delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.example.Configuration.HibernateConfiguration;
import com.example.Customer;

@WebServlet("/deleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final SessionFactory sessionFactory = HibernateConfiguration.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        try {
            long customerId = Long.parseLong(idParam);
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            Customer customer = session.get(Customer.class, customerId);
            session.delete(customer);
            transaction.commit();

 request.getSession().setAttribute("successMessage", "Customer deleted successfully.");
        } catch (Exception e) {
            System.out.println(e);
            
        }

        response.sendRedirect("customerListServlet");
    }
}
