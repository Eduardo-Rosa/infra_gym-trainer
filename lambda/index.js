const AWS = require('aws-sdk');
const { MongoClient } = require('mongodb');

const s3 = new AWS.S3();
const client = new MongoClient(process.env.MONGODB_URI);

exports.handler = async (event) => {
  const imageId = event.pathParameters.id;

  try {
    await client.connect();
    const db = client.db('meuDB');
    const collection = db.collection('imagens');

    const imagem = await collection.findOne({ _id: imageId });
    if (!imagem) {
      return { statusCode: 404, body: 'Imagem não encontrada' };
    }

    const signedUrl = s3.getSignedUrl('getObject', {
      Bucket: process.env.S3_BUCKET,
      Key: imagem.arquivoS3,
      Expires: 120
    });

    return {
      statusCode: 200,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ url: signedUrl })
    };

  } catch (err) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: err.message })
    };
  } finally {
    await client.close();
  }
};
