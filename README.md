# Whether, a Sweater?

The **Whether, a Sweater?** is an application designed to help users plan their road trips by providing current and forecasted weather information for their destinations. This project follows a service-oriented architecture, with the back-end team responsible for developing and exposing the APIs that satisfy the requirements of the front-end team.

## Features
- **API Communication:** The front-end team communicates with the back-end team through a set of well-defined APIs.
- **Weather Information:** The application integrates with weather APIs to retrieve and display current and forecasted weather data at user-selected destinations.
- **Real-time Updates:** The weather information is updated in real-time to provide accurate and up-to-date weather forecasts.
- **Data Validation:** To ensure data accuracy and reliability, the back-end team has implemented robust error handling and data validation mechanisms.
- **Collaborative Development:** Close collaboration with the front-end team is maintained to understand and fulfill their requirements effectively.
- **Performance Optimization:** The APIs are optimized for high performance and scalability, capable of handling a large number of concurrent requests.
- **Quality Assurance:** Unit tests are conducted, and code reviews are performed to maintain code quality and identify and fix any bugs or issues.

## Technologies Used
- **Programming Language:** Ruby-on-Rails, PostgreSQL
- **APIs:** MapQuest Geocoding Api, Weather Api

## Testing
- **Framework**:** RSpec 
- **HTTP Request Recording:** VCR
- **HTTP Request Stubbing:** WebMock
- **Code Coverage:** SimpleCov

## Getting Started
To set up **Whether, a Sweater?** locally, follow the instructions below:

- Fork & Clone the repository
- Install the required dependencies using bundler:
```
bundle install
```
- Set up the database by running the following commands:
```
rails db:{drop,create,migrate,seed}
```
- Configure API keys: [Provide instructions on obtaining and configuring API keys]
- 
## Usage
SOnce you have completed the installation steps, you can start the Whether Sweater application locally by running:
```
rails s
```
This will start the server, and you can access the application by visiting http://localhost:3000 in your web browser.

## Goals
Expose an API that aggregates data from multiple external APIs
Expose an API that requires an authentication token
Expose an API for CRUD functionality
Determine completion criteria based on the needs of other developers
Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
