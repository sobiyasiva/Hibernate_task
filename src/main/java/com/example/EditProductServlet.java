package com.example;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@WebServlet("/editProductServlet")
public class EditProductServlet extends HttpServlet {
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
                double price = Double.parseDouble(request.getParameter("price"));
 try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            Product productToUpdate = session.get(Product.class, id); 

            if (productToUpdate != null) {
                productToUpdate.setProductName(name);
                productToUpdate.setPrice(price);
                
                session.update(productToUpdate);
                transaction.commit();
            } 
        } catch (Exception e) {System.out.println(e);
            return;
        }
        request.getSession().setAttribute("successMessage", "Product updated successfully.");
        response.sendRedirect("product");
            }
        }