FROM mcr.microsoft.com/dotnet/sdk:8.0 AS restore
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

COPY BlazorBlog/BlazorBlog.csproj BlazorBlog/
COPY BlazorBlog.Client/BlazorBlog.Client.csproj BlazorBlog.Client/
COPY BlazorBlogLibrary/BlazorBlogLibrary.csproj BlazorBlogLibrary/
RUN dotnet restore BlazorBlog/BlazorBlog.csproj

FROM node:alpine AS nodetailwind
WORKDIR /src
COPY . .
WORKDIR /src/BlazorBlog
RUN npm run tailwind

FROM restore AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY --from=nodetailwind /src .
WORKDIR /src/BlazorBlog
RUN dotnet build BlazorBlog.csproj -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish BlazorBlog.csproj -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 8080
EXPOSE 8081
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlazorBlog.dll"]