import Leaf
import Vapor
import MySQL
import FluentMySQL
import Authentication

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  try services.register(LeafProvider())

  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)

  // MySQL
  try services.register(FluentMySQLProvider())
  
  var mysqlConfig: MySQLDatabaseConfig
  if env == .production {
    let url = Environment.get("DB_MYSQL") ?? "no-env-variable-DB_MYSQL"
    guard let mysqlDatabaseConfig = try MySQLDatabaseConfig(url: url) else {
      throw MySQLError.couldNotCreateConfigBasedOnURL
    }
    
    mysqlConfig = mysqlDatabaseConfig
  } else {
    mysqlConfig = MySQLDatabaseConfig(
      hostname: Environment.get("DATABASE_HOSTNAME") ?? "127.0.0.1",
      port: 3306,
      username: Environment.get("DATABASE_USER") ?? "vapor_username",
      password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
      database: Environment.get("DATABASE_DB") ?? "vapor_database"
    )
  }
  
  let mysql = MySQLDatabase(config: mysqlConfig)

  var databases = DatabasesConfig()
  databases.add(database: mysql, as: .mysql)
  services.register(databases)
  
  // Migration
  var migrations = MigrationConfig()
  migrations.add(model: User.self, database: .mysql)
  
  migrations.add(model: RangeQuestion.self, database: .mysql)
  migrations.add(model: RangeAnswer.self, database: .mysql)
  migrations.add(model: FourQuestion.self, database: .mysql)
  migrations.add(model: FourAnswer.self, database: .mysql)
  migrations.add(model: TwoQuestion.self, database: .mysql)
  migrations.add(model: TwoAnswer.self, database: .mysql)
  migrations.add(model: FreeQuestion.self, database: .mysql)
  migrations.add(model: FreeAnswer.self, database: .mysql)
  migrations.add(model: ThreeQuestion.self, database: .mysql)
  migrations.add(model: ThreeAnswer.self, database: .mysql)
  
  // Seeds
  migrations.add(migration: RangeQuestionSeed.self, database: .mysql)
  migrations.add(migration: FourQuestionSeed.self, database: .mysql)
  migrations.add(migration: TwoQuestionSeed.self, database: .mysql)
  migrations.add(migration: FreeQuestionSeed.self, database: .mysql)
  migrations.add(migration: ThreeQuestionSeed.self, database: .mysql)
  
  services.register(migrations)
  
  // MARK: - Config
  
  //Leaf
  config.prefer(LeafRenderer.self, for: ViewRenderer.self)
  
  // Auth
  config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
  

  // MARK: - Middleware
  
  var middlewares = MiddlewareConfig()
  
  middlewares.use(FileMiddleware.self)
  middlewares.use(ErrorMiddleware.self)
  
  // Auth
  try services.register(AuthenticationProvider())
  middlewares.use(SessionsMiddleware.self)
  
  services.register(middlewares)
}

enum MySQLError: Error {
  case couldNotCreateConfigBasedOnURL
}
