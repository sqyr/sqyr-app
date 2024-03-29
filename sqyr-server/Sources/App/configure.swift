import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
//
//    app.migrations.add(CreateTodo())

    app.databases.use(.postgres(hostname: "localhost", username: "sqyr", password: "9yg8Fd-A", database: "sqyr"), as: .psql)

    app.migrations.add(CreateLandmark())
    app.migrations.add(CreateClassroom())
    app.migrations.add(CreateStudyRoom())
    app.migrations.add(CreateUser())

    // register routes
    try routes(app)
}
