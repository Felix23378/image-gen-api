// API to verify the Node.js runtime Vercel is using
export default function handler(req, res) {
  res.status(200).json({
    message: 'Runtime check successful!',
    nodeVersion: process.version, // This will show the actual runtime Vercel is using
    success: true
  });
}