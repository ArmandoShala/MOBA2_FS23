import React, { useState } from 'react';
import { View, TextInput, Button } from 'react-native';

interface ParentProps {
    navigation: any; // assuming you're passing navigation prop from a navigator
}

const Parent: React.FC<ParentProps> = ({ navigation }) => {
    const [inputValue, setInputValue] = useState('');

    const handleInputChange = (text: string) => {
        setInputValue(text);
    };

    const navigateToChild = () => {
        navigation.navigate('Child', { inputValue });
    };

    return (
        <View>
            <TextInput
                value={inputValue}
                onChangeText={handleInputChange}
                placeholder="Enter input"
            />
            <Button title="Go to Child" onPress={navigateToChild} />
        </View>
    );
};

export default Parent;
