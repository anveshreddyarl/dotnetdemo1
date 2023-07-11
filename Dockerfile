FROM mcr.microsoft.com/dotnet/sdk:5.0

#Set up a non-root user
RUN groupadd -g 1001 appuser && \
    && useradd -r -u 1001 -g appuser appuser

USER appuser

# Copy the application files
COPY . /app

# Set the working directory
WORKDIR /app

# Build the application
RUN dotnet build

# Expose the necessary port
EXPOSE 80

# Start the application
CMD ["dotnet", "run"]