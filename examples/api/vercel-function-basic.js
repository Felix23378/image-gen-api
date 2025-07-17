// Basic working Vercel serverless function
export default function handler(req, res) {
  res.status(200).json({ 
    message: 'Function deployed successfully',
    method: req.method,
    timestamp: new Date().toISOString()
  });
}