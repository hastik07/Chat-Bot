-- Create messages table for the AI chatbot app
CREATE TABLE IF NOT EXISTS messages (
    id TEXT PRIMARY KEY,
    sender_id TEXT NOT NULL,
    content TEXT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status INTEGER NOT NULL DEFAULT 0, -- 0: sent, 1: delivered, 2: read
    type INTEGER NOT NULL DEFAULT 0, -- 0: text, 1: emoji, 2: media
    media_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create index for better query performance
CREATE INDEX IF NOT EXISTS idx_messages_timestamp ON messages(timestamp);
CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON messages(sender_id);

-- Enable Row Level Security (RLS)
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations for now (you can restrict this later)
CREATE POLICY "Allow all operations on messages" ON messages
    FOR ALL USING (true);

-- Insert some sample messages for testing
INSERT INTO messages (id, sender_id, content, timestamp, status, type) VALUES
    ('1', 'ai', 'Hello! I''m your AI assistant. How can I help you today? 😊', NOW(), 2, 0),
    ('2', 'user', 'Hi there!', NOW() - INTERVAL '1 minute', 2, 0),
    ('3', 'ai', 'Hi! Nice to meet you! What would you like to chat about?', NOW() - INTERVAL '30 seconds', 2, 0);

-- Grant necessary permissions
GRANT ALL ON messages TO authenticated;
GRANT ALL ON messages TO anon; 