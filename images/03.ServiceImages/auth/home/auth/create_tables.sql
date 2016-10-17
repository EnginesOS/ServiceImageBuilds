  CREATE TABLE IF NOT EXISTS users (
    userid VARCHAR(64) NOT NULL UNIQUE,
    passwd VARCHAR(32) NOT NULL,
    uid INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
    gid INTEGER,
    realname VARCHAR(255),
    ftphomedir VARCHAR(255),
    nfshomedir VARCHAR(255),
    shell VARCHAR(255),
    last_accessed DATETIME,
    min int(11) NOT NULL default '0',
  max int(11) NOT NULL default '0',
  warn int(11) NOT NULL default '7',
  inact int(11) NOT NULL default '-1',
  expire int(11) NOT NULL default '-1',
    use_count int
  );

  
CREATE TABLE IF NOT EXISTS groups (
    groupname VARCHAR(30) NOT NULL,
    gid INTEGER UNIQUE,
    members VARCHAR(255)
  );
   
    
  CREATE TABLE IF NOT EXISTS login_history (
    user VARCHAR(32) NOT NULL,
    client_ip VARCHAR(64) NOT NULL,
    server_ip VARCHAR(64) NOT NULL,
    protocol VARCHAR(16) NOT NULL,
    last_when DATETIME not null
  );
  
  #these baff if already created but who cares at this stage
  
  CREATE INDEX  groups_gid_idx ON groups (gid);
  CREATE INDEX   users_userid_idx ON users (userid);