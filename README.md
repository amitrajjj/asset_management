# Asset Tracking & Management System

A complete full-stack web application for tracking and managing organizational assets. Built with Node.js/Express backend, MySQL database, and vanilla HTML/CSS/JavaScript frontend.

## Features

- **Authentication & Authorization**: JWT-based auth with role-based access (admin/manager/user)
- **Asset Management**: Create, read, update, and delete assets
- **Asset Assignment**: Assign assets to users and track ownership
- **Asset Transfer**: Transfer assets between users
- **Transaction History**: Complete audit trail of all asset activities
- **Reporting**: Export usage reports as CSV
- **Search & Filter**: Find assets by name, status, category
- **Responsive UI**: Clean, modern interface that works on all devices

## Tech Stack

- **Backend**: Node.js, Express.js, Sequelize ORM
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Authentication**: JWT + bcrypt
- **File Export**: CSV reports

## Project Structure

```
asset-system/
├─ backend/
│  ├─ package.json
│  ├─ .env.example
│  ├─ src/
│  │  ├─ server.js
│  │  ├─ config.js
│  │  ├─ db.js
│  │  ├─ models/
│  │  │  ├─ User.js
│  │  │  ├─ Asset.js
│  │  │  ├─ Transaction.js
│  │  ├─ routes/
│  │  │  ├─ auth.js
│  │  │  ├─ assets.js
│  │  │  ├─ reports.js
│  │  ├─ middleware/
│  │  │  ├─ auth.js
│  │  ├─ seed.js
├─ frontend/
│  ├─ index.html
│  ├─ styles.css
│  ├─ app.js
│  ├─ assets.js
│  ├─ auth.js
├─ database-setup.sql
└─ README.md
```

## Prerequisites

- **Node.js** (v18 or higher)
- **MySQL** (v8.0 or higher)
- **npm** (comes with Node.js)

## Installation & Setup

### 1. Database Setup

1. Start your MySQL server
2. Open MySQL client (command line, phpMyAdmin, or MySQL Workbench)
3. Run the SQL commands from `database-setup.sql`:

```sql
-- Create database and user
CREATE DATABASE asset_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'assetuser'@'localhost' IDENTIFIED BY 'assetpass';
GRANT ALL PRIVILEGES ON asset_db.* TO 'assetuser'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Backend Setup

1. Navigate to the backend directory:
```bash
cd asset-system/backend
```

2. Install dependencies:
```bash
npm install
```

3. Create environment file:
```bash
cp .env.example .env
```

4. Edit `.env` file with your database credentials:
```env
PORT=4000
JWT_SECRET=your_super_secret_jwt_key_here
DB_HOST=localhost
DB_PORT=3306
DB_NAME=asset_db
DB_USER=assetuser
DB_PASS=assetpass
```

5. Seed the database with sample data:
```bash
npm run seed
```

6. Start the development server:
```bash
npm run dev
```

The backend API will be available at `http://localhost:4000`

### 3. Frontend Setup

#### Option A: Simple HTTP Server (Recommended)

1. Navigate to the frontend directory:
```bash
cd asset-system/frontend
```

2. Start a simple HTTP server:

**Using Python (if installed):**
```bash
python -m http.server 5174
```

**Using Node.js http-server:**
```bash
npx http-server -p 5174
```

3. Open your browser and go to `http://localhost:5174`

#### Option B: Serve from Backend

1. Add this line to `backend/src/server.js` after the other middleware:
```javascript
app.use(express.static(path.join(__dirname, '../../frontend')));
```

2. Add this import at the top:
```javascript
const path = require('path');
```

3. Access the frontend at `http://localhost:4000`

## Default Login Credentials

The seed script creates these test accounts:

- **Admin**: `admin@example.com` / `adminpass`
- **Manager**: `manager@example.com` / `managerpass`
- **User**: `amit@example.com` / `userpass`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `GET /api/auth/users` - List users (admin/manager only)

### Assets
- `GET /api/assets` - List assets (with search/filter)
- `POST /api/assets` - Create asset (admin/manager only)
- `GET /api/assets/:id` - Get asset details
- `PUT /api/assets/:id` - Update asset (admin/manager only)
- `POST /api/assets/:id/assign` - Assign asset to user
- `POST /api/assets/:id/transfer` - Transfer asset between users
- `POST /api/assets/:id/transaction` - Record transaction
- `GET /api/assets/:id/history` - Get asset transaction history

### Reports
- `GET /api/reports/usage` - Download usage report CSV (admin/manager only)

## User Roles & Permissions

### Admin
- Full access to all features
- Can create, edit, delete assets
- Can assign and transfer assets
- Can view all reports
- Can manage users

### Manager
- Can create, edit assets
- Can assign and transfer assets
- Can view reports
- Cannot delete assets or manage users

### User
- Can view assets
- Can record transactions (checkout/checkin)
- Limited reporting access

## Development

### Backend Development
```bash
cd backend
npm run dev  # Uses nodemon for auto-restart
```

### Database Reset
To reset the database with fresh seed data:
```bash
cd backend
npm run seed
```

### Adding New Features

1. **New API Endpoint**: Add routes in `backend/src/routes/`
2. **New Database Table**: Create model in `backend/src/models/`
3. **Frontend Feature**: Add JavaScript in `frontend/` directory

## Production Deployment

### Environment Variables
Set these environment variables in production:
- `JWT_SECRET`: Strong secret key for JWT tokens
- `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`: Production database credentials
- `PORT`: Server port (default: 4000)

### Database
- Use a production MySQL instance
- Run the database setup SQL
- Run the seed script for initial data

### Security Considerations
- Change default JWT secret
- Use strong database passwords
- Enable HTTPS in production
- Implement rate limiting
- Add input validation
- Use environment variables for sensitive data

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials in `.env`
   - Ensure database and user exist

2. **CORS Issues**
   - Backend includes CORS middleware
   - Ensure frontend and backend URLs match

3. **Authentication Issues**
   - Check JWT secret consistency
   - Verify token storage in browser localStorage

4. **Port Conflicts**
   - Change PORT in `.env` if 4000 is occupied
   - Update API_BASE in `frontend/auth.js`

### Logs
- Backend logs appear in terminal where `npm run dev` is running
- Frontend errors appear in browser developer console

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Support

For issues and questions:
1. Check the troubleshooting section
2. Review the API documentation
3. Check browser developer console for frontend issues
4. Review backend terminal logs for server issues
