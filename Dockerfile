FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -
RUN apt-get -y install nodejs

COPY . ./
RUN dotnet restore

RUN dotnet build "dotnet6.csproj" -c Release

RUN dotnet publish "dotnet6.csproj" -c Release -o publish


FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /app
COPY --from=build /app/publish .

RUN groupadd -r anvesh && \
    useradd -r -g anvesh -s /bin/false anvesh && \
    chown -R anvesh:anvesh /app

USER anvesh

EXPOSE 5000
ENTRYPOINT ["dotnet", "dotnet6.dll"]