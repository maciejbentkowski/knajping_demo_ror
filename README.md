# My Ruby on Rails Application

This is a Ruby on Rails application designed to manage a dynamic web experience using a modern tech stack. This project is configured for high performance, development ease, and production readiness. Below are the details to get you started.
## Requirements

- **Ruby**: 3.3.5 (using rbenv recommended)
- **Rails**: 8.1.0.alpha
- **PostgreSQL**: 16 or higher
## Getting Started

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/maciejbentkowski/knajping.git

cd knajping
```

2. **Install dependencies**:
```bash
bundle install
```

3. **Set up the database**: Ensure PostgreSQL is installed and configured. Then run:
```bash
rails db:create db:migrate db:seed
```
## Running the App

To start the Rails server locally, run:
   ```bash
   bin/dev
   ```
   
Then, visit http://localhost:3000 in your browser.
## Testing

This app is set up with RSpec for testing. Run all tests with:

```bash
rspec
```
## Key Technologies

- **Rails**: Main branch for core functionality
- **PostgreSQL**: Database management
- **Tailwind CSS**: For styling
- **Turbo-Rails & Stimulus-Rails**: Enhanced frontend interactivity
- **Devise**: Authentication
- **ActiveStorage**: File and image management
- **RSpec & FactoryBot**: For testing
- **SolidCache, SolidQueue, SolidCable**: Caching, background jobs, and WebSocket support
- **AWS S3**: For file storage (optional)
