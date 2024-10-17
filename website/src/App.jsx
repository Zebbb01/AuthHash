import React, { useState } from 'react';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Login from './components/Login/Login';
import Signup from './components/SignUp/Signup';
import Dashboard from './components/Dashboard/Dashboard';
import './App.css';
import Spinner from './components/Spinner/Spinner'; // Import the Spinner component

function App() {
  const [isLogin, setIsLogin] = useState(true);
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false); // Loading state

  const toggleForm = () => {
    setLoading(true); // Start spinner
    setTimeout(() => {
      setIsLogin(!isLogin);
      setLoading(false); // Stop spinner after the page changes
    }, 1000); // Simulate delay for loading
  };

  const logout = () => {
    setUser(null);
  };

  return (
    <div className="App">
      <header className="App-header">
        {loading ? ( // Show spinner when loading
          <Spinner />
        ) : (
          <>
            {!user ? (
              <>
                {isLogin ? <Login setUser={setUser} /> : <Signup setIsLogin={setIsLogin} />}
                <span className="toggle-span" onClick={toggleForm}>
                  {isLogin ? "Don't have an account? Sign Up" : "Already have an account? Log In"}
                </span>
              </>
            ) : (
              <Dashboard user={user} logout={logout} />
            )}
          </>
        )}
      </header>
      <ToastContainer 
        position="top-center"
        autoClose={1500}
        hideProgressBar={true}  // Hide progress bar
        closeOnClick 
        pauseOnHover={false}    // Disable hover pausing
        className="toast-container-custom" // Custom class for styling
      />
    </div>
  );
}

export default App;
