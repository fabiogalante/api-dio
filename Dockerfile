FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build-env
 
WORKDIR /app
 
COPY api-dio.csproj ./
 
RUN dotnet restore
 
COPY . ./
 
RUN dotnet publish -c Release -o out
 
FROM mcr.microsoft.com/dotnet/aspnet:5.0
 
WORKDIR /app
 
COPY --from=build-env /app/out .
 
EXPOSE 80
 
ENTRYPOINT [ "dotnet", "api-dio.dll" ]