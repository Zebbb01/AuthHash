import React from 'react';
import { toast } from 'react-toastify';
import './Dashboard.css';

const Dashboard = ({ user, logout }) => {
  const handleLogout = () => {
    logout(); 
    toast.info("You have been logged out!"); 
  };

  return (
    <div className="dashboard-container">
      <h2 className="welcome-message">Welcome, {user.name}</h2>
      <table className="user-info-table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Hashed Password</th>
            <th>Pepper</th> {/* Display pepper */}
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{user.name}</td>
            <td>{user.email}</td>
            <td>{user.password}</td>
            <td>{user.hashed_password}</td>
            <td>{user.pepper}</td> {/* Show pepper */}
          </tr>
        </tbody>
      </table>
      <button onClick={handleLogout} className="logout-button">Logout</button>
    </div>
  );
};

export default Dashboard;
