import { NavLink } from 'react-router-dom';
import React, { useState } from 'react';

const Sidebar = ({ activeTab, setActiveTab }) => {
return (
    <div className="sidebar">
        <div
        className={`sidebar-item ${activeTab === 'requests' ? 'active' : ''}`}
        onClick={() => setActiveTab('requests')}
        >
        Purchase Request
        </div>


        <div
        className={`sidebar-item ${activeTab === 'inventory' ? 'active' : ''}`}
        onClick={() => setActiveTab('inventory')}
        >
        Inventory
        </div>
    </div>
    );
};


export default Sidebar;