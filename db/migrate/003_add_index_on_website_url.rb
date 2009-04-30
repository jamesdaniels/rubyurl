class AddIndexOnWebsiteUrl < ActiveRecord::Migration
  def self.up
    case (ActiveRecord::Base.connection.adapter_name)
      when 'MySQL':
        execute 'ALTER TABLE links ENGINE = MyISAM'
        execute 'CREATE INDEX website_url_index ON links (website_url(200))'
      when 'PostgreSQL':
        execute 'CREATE INDEX website_url_index ON links ((substring(website_url, 0, 200)));'
      else
        raise "Unsupported database adapter, please add necessary SQL to db/migrate/003_add_index_on_website_url.rb"
    end
  end

  def self.down
    execute 'DROP INDEX website_url_index ON links;'
    execute 'ALTER TABLE links ENGINE = InnoDB' if ActiveRecord::Base.connection.adapter_name == 'MySQL'
  end
end