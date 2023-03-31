<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiController extends Controller
{
    //
    public function index(){
        $data =[
           "Success" => "working fine"     
        ];
        return response()->json($data);
    }
    
    public function store(Request $request)
    {
       // Validate the incoming request data
        $validatedData = $request->validate([
            'data' => 'required|string',
        ]);

        // Store the data in the "iot" table
        DB::table('iot')->insert([
            'data' => $validatedData['data'],
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        $data = [
            'success' => true,
            'message' => 'Data stored successfully',
        ];

        return response()->json($data);
    }
}
