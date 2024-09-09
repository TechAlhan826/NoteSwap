import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config();

const supabase=createClient(process.env.SUPABASE_URL,process.env.SUPABASE_API_KEY,{autoRefreshToken:true});
export default supabase;