# Blood Management System (BMS)

A comprehensive system for managing blood bank operations, donor information, and blood inventory.

## Developers
- UWIMPUHWE Hyacinthe Mireille
- CANIRINYANA Diane

## Prerequisites
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Composer (PHP package manager)
- XAMPP/WAMP/LAMP stack
- Web browser (Chrome, Firefox, Safari, or Edge)

## Installation Steps

1. **Clone the Repository**
   ```bash
   git clone [repository-url]
   cd bms_ussd
   ```

2. **Install Dependencies**
   ```bash
   composer install
   ```

3. **Database Setup**
   - Open phpMyAdmin (http://localhost/phpmyadmin)
   - Create a new database named `bms_ussd`
   - Import the database schema from `database/bms_ussd.sql`

4. **Configuration**
   - Copy `.env.example` to `.env`
   - Update the following configurations in `.env`:
     ```
     DB_HOST=localhost
     DB_NAME=bms_ussd
     DB_USER=root
     DB_PASS=
     ```

5. **SMS Integration**
   - The system uses Africa's Talking for SMS notifications
   - API key is configured in `sms.php`
   - Update the API key if needed

## Running the System

1. **Start XAMPP**
   - Start Apache and MySQL services from XAMPP Control Panel

2. **Access the System**
   - Open your web browser
   - Navigate to: `http://localhost/bms_ussd`



## Features
- Blood Donor Management
- Blood Inventory Tracking
- Blood Request Management
- SMS Notifications
- Reports Generation
- User Management


```

## Support
For technical support or questions, please contact:
- Email: [uwmireille55@gmail.com]
- Phone: [0780037017]

