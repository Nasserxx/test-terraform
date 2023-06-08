ARG SDK=mcr.microsoft.com/dotnet/sdk
ARG RUNTIME=mcr.microsoft.com/dotnet/aspnet
FROM $SDK:7.0-alpine AS base
WORKDIR /app
COPY . .
RUN dotnet restore weatherapi.csproj
RUN dotnet build weatherapi.csproj -c Release -o /app/build
RUN dotnet publish weatherapi.csproj -c Release -o /app/publish


FROM $RUNTIME:7.0-alpine as final
WORKDIR /app
COPY --from=base /app/publish .
EXPOSE 80
EXPOSE 443
EXPOSE 5000

ENTRYPOINT ["dotnet", "weatherapi.dll"]