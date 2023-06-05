import React, { useState } from 'react';
import axios from 'axios';
import HomePage from './HomePage';
import './Authentication.scss';

const Authentication = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.get('http://127.0.0.1:5000/api/user/login');
      if (response.status === 200) {
        const data = response.data;
        // Traitez les données récupérées
        
      } else {
        setError('An error occurred.');
      }
    } catch (error) {
      setError('An error occurred.');
    }
  };

  return (
    <div className="authentication">
      <div className="authentication-container">
        <h1 className="authentication-logo">LOGO</h1>
        <form className="authentication-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="username">Username</label>
            <input
              type="text"
              id="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <button type="submit" className="btn-login">Login</button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Authentication;
