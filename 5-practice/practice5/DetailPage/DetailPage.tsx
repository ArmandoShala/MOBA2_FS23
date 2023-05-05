import React, { useState } from 'react';
import {View, Text, TextInput, Button, StyleSheet} from 'react-native';
import {RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../App';

type SubPageRouteProp = RouteProp<RootStackParamList, 'DetailPage'>;

type Props = {
    route: SubPageRouteProp;
};

export default function DetailPage({route}: Props) {
    const {userInput} = route.params;

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Your Input:</Text>
            <Text style={styles.input}>{userInput}</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    title: {
        fontSize: 24,
        marginBottom: 20,
    },
    input: {
        fontSize: 18,
        borderWidth: 1,
        borderColor: 'gray',
        paddingHorizontal: 10,
        width: '80%',
        marginBottom: 20,
        textAlign: 'center',
    },
});
