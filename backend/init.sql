CREATE TABLE voters (
    voter_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    INDEX (email)
);

CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    election_id INT,
    party VARCHAR(100),
    INDEX (election_id),
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

CREATE TABLE elections (
    election_id INT PRIMARY KEY,
    election_name VARCHAR(255) NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY,
    voter_id INT,
    candidate_id INT,
    election_id INT,
    vote_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX (voter_id),
    INDEX (candidate_id),
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id),
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

CREATE TABLE audit_logs (
    log_id INT PRIMARY KEY,
    action VARCHAR(255),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    INDEX (user_id)
);

CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    voter_id INT,
    session_start DATETIME DEFAULT CURRENT_TIMESTAMP,
    session_end DATETIME,
    INDEX (voter_id),
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id)
);

CREATE TABLE registration_queue (
    registration_id INT PRIMARY KEY,
    voter_id INT,
    request_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(100),
    INDEX (voter_id),
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id)
);

CREATE TABLE vote_backups (
    backup_id INT PRIMARY KEY,
    vote_id INT,
    backup_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX (vote_id),
    FOREIGN KEY (vote_id) REFERENCES votes(vote_id)
);