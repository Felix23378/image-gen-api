// Simple test endpoint to verify deployment
export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Test endpoint working',
      environment: process.env.NODE_ENV || 'development'
    });
  }

  if (req.method === 'POST') {
    return res.status(200).json({
      success: true,
      message: 'POST request received',
      body: req.body
    });
  }

  return res.status(405).json({ error: 'Method not allowed' });
}