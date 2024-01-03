FROM  mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore 
# copy and publish app and libraries
COPY . .
RUN dotnet publish -c Release  -o /app


# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 8080
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["./aspnetapp"]
