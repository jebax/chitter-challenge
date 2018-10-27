require_relative "database_manager"

class User
  attr_reader :id, :email, :password, :name, :username

  def self.all
    select_all.map do |user|
      create_user_instance(user)
    end
  end

  def self.create(email, password, name, username)
    DatabaseManager.query("INSERT INTO users(email,password,name,username)" \
      "VALUES('#{email}','#{password}', '#{name}', '#{username}') " \
      "RETURNING id, email, password, name, username")
  end

  def self.select_all
    DatabaseManager.query('SELECT * FROM users')
  end

  def self.find(id = nil)
    return nil unless id
    user = DatabaseManager.query("SELECT * FROM users WHERE " \
      "id = '#{id}'").first
    create_user_instance(user)
  end

  def self.create_user_instance(user)
    User.new(
      id: user['id'], email: user['email'], password: user['password'],
      name: user['name'], username: user['username']
    )
  end

  def self.authenticate(email, _password)
    user = DatabaseManager.query("SELECT * FROM users WHERE " \
      "email = '#{email}'").first
    create_user_instance(user)
  end

  def initialize(id:, email:, password:, name:, username:)
    @id = id
    @email = email
    @password = password
    @name = name
    @username = username
  end

  private_class_method :select_all, :create_user_instance
end