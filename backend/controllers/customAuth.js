const authRouter=require('express').Router();   
const supabase=require('../supabaseclient');
const supabaseAdmin=require('../supabaseAdmin');
const authenticateUser=require('../utils/middleware').authenticateUser;


authRouter.post('/signup',async(req,res)=>{

    const {email,username,password}=req.body
    try{
        const {data,error}=await supabase.auth.signUp({email,password,
            options:{
                data:{username},
                emailRedirectTo:null,
                emailConfirmation:false
            }
        })
        if(error){
            throw error
        }

        res.status(201).json({message:"Succesful signup",data})

    }
    catch(err){
        res.status(404).json({error:err.message})
    }

})

authRouter.post('/login',async(req,res)=>{
    const {email,username,password}=req.body

    try{
        const {data,error}=await supabase.auth.signInWithPassword({email,password})
        if(error){
            throw error
        }

        res.status(200).json({
            message: "Successful login",
            session: {
                access_token: data.session.access_token,
                refresh_token: data.session.refresh_token,
                expires_at: data.session.expires_at
            }
        });
    }
    catch(err){
        res.status(404).json({error:err.message})
    }    
})

authRouter.post('/logout',async(req,res)=>{
    const token=req.headers.authorization?.split(' ')[1];
    try{
        const {error}=await supabase.auth.admin.signOut(token);
        if(error){
            throw error
        }
        res.status(200).json({message:"Succesful logout"})  
    }
    catch(err){
        res.status(404).json({error:err.message})
    }
})

authRouter.post('/refresh',async(req,res)=>{
    const {refreshToken}=req.body
    console.log(refreshToken);
    

    try{
        const { data,error }=await supabase.auth.refreshSession()
        if(error){
            throw error
        }
        res.status(200).json({
            message: "Token refreshed successfully",
            session: {
                access_token: data.session.access_token,
                refresh_token: data.session.refresh_token,
                expires_at: data.session.expires_at
            }
        })
    }
    catch(err){
        res.status(401).json({error:'Invalid/expired refresh token'})
    }
})


authRouter.post('/updatePassword',authenticateUser,async(req,res)=>{
    const {new_password}=req.body
    if(!new_password){
        return res.status(400).json({error:"Password cannot be empty"})
    }

    try{
        const {data,error}=await supabase.auth.updateUser({password:new_password})
        if(error){
            throw error
        }
        res.status(200).json({message:"Password updated successfully"})
    }
    catch(err){
        res.status(404).json({error:err.message})
    }
})

authRouter.post('/reset-password', async (req, res) => {
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ error: 'Email is required' });
    }

    try {
        const { data, error } = await supabase.auth.resetPasswordForEmail(email, {
            redirectTo: 'url-to-redirect-to-after-user-clicks-email'
        });

        if (error) {
            throw error;
        }

        res.status(200).json({ message: 'Password reset email sent successfully' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

authRouter.post('/deleteUser',authenticateUser,async(req,res)=>{
    const id=req.user.id
    try{
        const {data,error}=await supabaseAdmin.auth.admin.deleteUser(id)
        if(error){
            throw error
        }
        res.status(200).json({message:"User deleted successfully"})
    }
    catch(err){
        res.status(404).json({error:err.message})
    }
})

module.exports=authRouter;



