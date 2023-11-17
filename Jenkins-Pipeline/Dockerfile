# official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the remaining source code
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# official .NET Runtime image as the base image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# working directory inside the container
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/out .

# command to run your .NET application
CMD ["dotnet", "MyDotNetApp.dll"]

# Expose port to check
EXPOSE 80
