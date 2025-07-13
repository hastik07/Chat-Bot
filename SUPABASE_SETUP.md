# Supabase Setup for AI Chatbot App

## 🚀 Quick Setup

### 1. Create the Messages Table

Go to your Supabase dashboard and run this SQL in the SQL Editor:

```sql
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
```

### 2. Enable Real-time for Messages Table

1. Go to **Database** → **Replication** in your Supabase dashboard
2. Find the `messages` table
3. Enable **Insert**, **Update**, and **Delete** for real-time

### 3. Verify Your Supabase Configuration

Make sure your `main.dart` has the correct Supabase URL and anon key:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

## 🔧 Troubleshooting

### Error: "PostgrestException: 404 Not Found"
- **Cause**: The `messages` table doesn't exist
- **Solution**: Run the SQL script above

### Error: "Permission denied"
- **Cause**: RLS policies are too restrictive
- **Solution**: The SQL script includes a permissive policy for testing

### Messages not appearing in real-time
- **Cause**: Real-time not enabled for the table
- **Solution**: Enable real-time in Database → Replication

## 📱 Testing

After setup:
1. Run your Flutter app
2. Navigate to the chat screen
3. Send a message
4. The bot should respond within 2 seconds

## 🔒 Security Note

The current setup allows all operations for testing. For production:
- Implement proper RLS policies based on user authentication
- Restrict access to user-specific messages
- Add proper validation and sanitization 